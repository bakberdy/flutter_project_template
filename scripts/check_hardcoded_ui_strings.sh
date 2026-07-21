#!/usr/bin/env bash

set -euo pipefail

repository_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

exec perl - "$repository_root" <<'PERL'
use strict;
use warnings;
use utf8;
use File::Find;
use File::Spec;

binmode STDOUT, ':encoding(UTF-8)';
binmode STDERR, ':encoding(UTF-8)';

my ($repository_root) = @ARGV;
my @scanned_roots = qw(apps modules);
my $allowed_comment = 'hardcoded-ui-text: allow';
my @violations;

my @patterns = (
    qr/(?:const\s+)?Text\s*\(\s*(['"])(.*?)\1/s,
    qr/\b(?:title|message|description|label|hintText|helperText|errorText|tooltip|semanticLabel|primaryLabel|secondaryLabel|emptyText)\s*:\s*(['"])(.*?)\1/s,
);

sub should_scan {
    my ($path) = @_;
    $path =~ s{\\}{/}g;

    return 0 if $path !~ /\.dart\z/;
    return 0 if $path !~ m{/lib/};
    return 0 if $path =~ m{/(?:gen|l10n)/};
    return 0 if $path =~ /\.(?:g|gr|freezed|config)\.dart\z/;

    return $path =~ m{/(?:presentation|widgets|screens|app)/}
        || $path =~ m{/shared/lib/src/(?:mappers|mixins)/};
}

sub is_user_facing_literal {
    my ($value) = @_;
    return 0 if $value eq '' || index($value, '$') >= 0;
    return $value =~ /[A-Za-zА-Яа-яЁёҚқӘәІіҢңҒғҮүҰұӨөҺһ]/;
}

sub is_explicitly_allowed {
    my ($source, $offset) = @_;
    my $line_start = rindex($source, "\n", $offset - 1) + 1;
    my $previous_line_end = $line_start > 0 ? $line_start - 1 : 0;
    my $previous_line_start = $previous_line_end > 0
        ? rindex($source, "\n", $previous_line_end - 1) + 1
        : 0;
    my $context = substr(
        $source,
        $previous_line_start,
        $offset - $previous_line_start,
    );
    return index($context, $allowed_comment) >= 0;
}

for my $root_name (@scanned_roots) {
    my $root = File::Spec->catdir($repository_root, $root_name);
    next if !-d $root;

    find(
        {
            no_chdir => 1,
            wanted => sub {
                my $path = $File::Find::name;
                return if !-f $path || !should_scan($path);

                open my $file, '<:encoding(UTF-8)', $path
                    or die "Could not read $path: $!\n";
                local $/;
                my $source = <$file>;
                close $file;

                for my $pattern (@patterns) {
                    while ($source =~ /$pattern/g) {
                        my $value = $2 // '';
                        my $offset = $-[0];
                        next if !is_user_facing_literal($value);
                        next if is_explicitly_allowed($source, $offset);

                        my $line = 1 + (substr($source, 0, $offset) =~ tr/\n//);
                        my $relative_path = File::Spec->abs2rel(
                            $path,
                            $repository_root,
                        );
                        push @violations, qq{$relative_path:$line: "$value"};
                    }
                }
            },
        },
        $root,
    );
}

if (!@violations) {
    print "No hardcoded UI strings found.\n";
    exit 0;
}

print STDERR "Hardcoded UI strings found:\n";
print STDERR join("\n", @violations), "\n";
print STDERR 'Use the owning module localization or add "// ',
    $allowed_comment,
    '" for intentional non-localizable UI metadata.',
    "\n";
exit 1;
PERL
