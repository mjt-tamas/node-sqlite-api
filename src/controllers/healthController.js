exports.healthCheck = (_, res) => {
  res.json({ status: 'OK', message: 'Health check passed' });
};
