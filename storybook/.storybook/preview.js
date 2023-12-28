/** @type { import('@storybook/server').Preview } */
console.log(process.env.STORYBOOK_PROJECT_BASE_PROTOCOL)
const preview = {
  globals: {
    drupalTheme: 'umami',
    supportedDrupalThemes: {
      umami: {title: 'Umami'},
      claro: {title: 'Claro'},
    },
  },
  parameters: {
    server: {
      // Replace this with your Drupal site URL, or an environment variable.
      url: process.env.STORYBOOK_PROJECT_BASE_PROTOCOL + '://' + process.env.STORYBOOK_PROJECT_BASE_URL,
    },
    actions: { argTypesRegex: "^on[A-Z].*" },
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
  },
};

export default preview;
