/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  experimental: {
    turbo: {
      resolveAlias: {
        '@/*': ['./src/*'],
      },
    },
  },
};

module.exports = nextConfig;