# github-runner-dockerfile

Internal fork of a GitHub Actions runner Docker image.

## Status

This repository is maintained as an internal proprietary fork.

It is derived from MIT-licensed upstream work by Alessandro Baccini. The original MIT license terms are preserved in [LICENSE](LICENSE). Additional attribution is recorded in [NOTICE](NOTICE).

## Purpose

This repository contains a Docker-based GitHub Actions runner image intended for internal deployment and customization.

## Usage

When running the image, provide the environment variables required by the runner configuration, including the repository owner, repository name, and GitHub token.

When generating a GitHub personal access token for this workflow, ensure it includes the permissions needed by your internal deployment model. The original upstream documentation referenced `repo`, `workflow`, and `admin:org` scopes.

## Upstream Attribution

This fork is based on work originally published by Alessandro Baccini under the MIT License.

The original project description referenced this article:
https://baccini-al.medium.com/creating-a-dockerfile-for-dynamically-creating-github-actions-self-hosted-runners-5994cc08b9fb

The startup script was also credited upstream as being based on work from testdriven.io:
https://testdriven.io/blog/github-actions-docker/

## Licensing

This repository includes code derived from MIT-licensed software.

To remain compliant:

- keep the original MIT license text in [LICENSE](LICENSE)
- retain upstream attribution for the inherited portions of the codebase
- include the license notice when distributing copies or substantial portions of the software

Internal modifications may remain proprietary, subject to your organization's legal and compliance requirements.
