# Drupal & Storybook Integration Example

## TLDR

To quickly initialize your local environment, use the following command:

```bash
make init
```

This command sets up the necessary components, including Docker4Drupal, and prepares the environment for seamless integration of Drupal and Storybook.

After initialization:
- Drupal is accessible at [http://drupal.localhost](http://drupal.localhost)
- Storybook is accessible at [http://storybook.drupal.localhost](http://storybook.drupal.localhost)

## Overview

This project serves as an illustrative example of integrating Single Directory Components (SDC) in Drupal with Storybook, showcasing the seamless collaboration between Drupal and Storybook for efficient component development and documentation.

## Table of Contents

- [Background](#background)
- [Folder Structure](#folder-structure)
- [To Do](#to-do)
- [License](#license)

## Background

### Single Directory Components (SDC)

Drupal's Single Directory Components (SDC) provide a modular and organized approach to component-based development. Each component resides in a single directory, encapsulating its code, styles, and other related assets. SDCs enhance code reusability and maintainability, contributing to a more scalable and efficient development process.

### Storybook

Storybook is a powerful tool for developing UI components in isolation. It facilitates the creation, testing, and documentation of components in an isolated environment, enabling developers to focus on one component at a time. Storybook's versatility makes it an excellent companion for Drupal, promoting a streamlined workflow for component-driven development.

### Docker4Drupal Integration

For an enhanced development environment, this project incorporates Docker4Drupal. Docker4Drupal is a set of Docker images designed for Drupal development, providing a robust and consistent infrastructure. With Docker4Drupal, you can easily set up and manage your Drupal environment, including services like Apache, PHP, MySQL, and more, using Docker containers.

## Folder Structure

The project follows a structured organization to ensure clarity and maintainability. The key directories include:

- **html**: Contains the Drupal installation.
- **mysql**: Contains a sample MySQL dump of the database.
- **storybook**: Contains Storybook configuration files.

## To Do

Integrate with Visual Regression Testing Tools such as Chromatic or Percy to ensure the visual consistency of components across different states and platforms.

## License

This project is licensed under the [MIT License](LICENSE.txt), allowing for both personal and commercial use. See the LICENSE file for details.

---

Feel free to explore the integration of Drupal and Storybook in this example project. Happy coding!