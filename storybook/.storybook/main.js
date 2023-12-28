/** @type { import('@storybook/server-webpack5').StorybookConfig } */
const config = {
  stories: [
    "/app/html/web/themes/**/*.stories.yml",
    "/app/html/web/modules/**/*.stories.yml"
  ],
  addons: ["@storybook/addon-links", "@storybook/addon-essentials", "@lullabot/storybook-drupal-addon"],
  framework: {
    name: "@storybook/server-webpack5",
    options: {
      builder: {
        useSWC: true,
      },
    },
  },
  docs: {
    autodocs: "tag",
  },
};
export default config;
