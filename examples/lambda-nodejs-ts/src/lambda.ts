import { handle } from './webhook/handler';

module.exports.handler = async (event: any, context: any, callback: any): Promise<any> => {
  const statusCode = await handle(event.headers, event.body);
  return callback(null, {
    statusCode: statusCode,
  });
};
