import { IncomingHttpHeaders } from 'http';
import crypto from 'crypto';

function signRequestBody(key: string, body: any): string {
  return `sha1=${crypto.createHmac('sha1', key).update(body, 'utf8').digest('hex')}`;
}

export const handle = async (headers: IncomingHttpHeaders, payload: any): Promise<number> => {
  // ensure header keys lower case since github headers can contain capitals.
  for (const key in headers) {
    headers[key.toLowerCase()] = headers[key];
  }

  const secret = process.env.GITHUB_APP_WEBHOOK_SECRET as string;
  const signature = headers['x-hub-signature'];

  if (!signature) {
    console.error("Github event doesn't have signature.");
    return 404;
  }

  const calculatedSig = signRequestBody(secret, payload);
  if (signature !== calculatedSig) {
    console.error('Unable to verify signature!');
    return 401;
  }

  const githubEvent = headers['x-github-event'];
  console.info(`Received Github event: "${githubEvent}"`);
  console.debug(JSON.parse(payload));

  return 200;
};
