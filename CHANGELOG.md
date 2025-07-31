# Changelog

All notable changes to this project will be documented in this file.

## 2025.07.31.0

[a10b3d8](a10b3d8a4f4c226b5835c8742addd8e23003b888)...[607c6e2](607c6e2cfadadb2a920a8acdd3640bb98452094a)

### Bug Fixes

* [9024b11](9024b110e3f5964d81fe308e2baeeae3d82f5b99): Add  UV_NO_MANAGED_PYTHON=1 in Dockerfile 
* [c541feb](c541feba258d1f780a1dba7a015a771fe1d12855): Pin uv version to 0.7 
* [607c6e2](607c6e2cfadadb2a920a8acdd3640bb98452094a): Update UV version from 0.7 to 0.8 in Dockerfile 

### Miscellaneous Tasks

* [ac89f6d](ac89f6de80d8cd7675df0fd31f0201471b1c47a3): Update Python version to 3.12 in .env and .python-version files 

### Refactor

* [ef09103](ef091030f5034c922d94caf23fcf97f89ab4d5b3): Rename task sections for clarity and add list-installed-python task 

## 2025.06.13.0

[917d3ea](917d3ea97f768e6784dadfd96d868baa507ac30e)...[591c248](591c24878b874689f5ccefc80953d810f5ecdb5f)

### Bug Fixes

* [935cf90](935cf9080f89501410e2f684e056aec892b5e3b3): Remove GoTask installation logic  from Dockerfile 
* [4534c3f](4534c3fdf5353b9900b716b75d9234822c6d5e72): Remove static analysis and pytesting stages from CI configuration 
* [591c248](591c24878b874689f5ccefc80953d810f5ecdb5f): Specify version for envconsul in Dockerfile 

### CI

* [888d242](888d2426507491ef2c25beb7440538bb613e6898): Refactoring CI Github actions 
* [ebe369f](ebe369ffbf0b74031b606499bb8dcc93d2339fd9): Refactoring CI GitLab pipelines 
* [a5021b8](a5021b8e42d2e5994f0496b0c6679584f4366e3b): Add build matrix trigger to GitLab CI configuration 

### Features

* [86fa138](86fa13871138525b3319c15322621a2565c6c9f3): Update Dockerfile 

### Miscellaneous Tasks

* [121b709](121b709b0c1c162c23e163f785888cc3f69d6e0a): Enhance Taskfile with new tasks for dependency management and pre-commit hooks 
* [b6a37c3](b6a37c3816de55a404bcec02f8db4f32d17e0615): Add project files 
* [93cc70c](93cc70c867bf2792814ed28e084c85b26654ebb9): Add git-cliff configuration for changelog generation 
* [78a58c1](78a58c1100d21c52cd29cd7c8e669672b6ef852a): Update pre-commit hooks to include lock file management 

### Testing

* [61b186f](61b186ff8f35e424d2878d64ac9d5b1f30f7e9e5): Remove obsolete scripts and add new testing scripts for Docker container and image 


====
