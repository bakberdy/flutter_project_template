import cf from "cloudfront";

const kvs = cf.kvs();

async function handler(event) {
  const request = event.request;
  const activeRelease = await kvs.get("active_release");
  let uri = request.uri || "/";
  const lastSegment = uri.split("/").pop();

  if (uri === "/" || !lastSegment.includes(".")) {
    uri = "/index.html";
  }

  request.uri = `/releases/${activeRelease}${uri}`;
  return request;
}
