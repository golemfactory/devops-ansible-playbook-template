## Ansible playbook template

It shows how to deploy an [example-web-service](https://github.com/golemfactory/example-web-service). It consists of:
- Yagna requestor
- A http backend that talks with requestor using yapapi
- Frontend written in Vue
- Nginx that
  - serves static frontend
  - proxies api calls to backend


## Requirements

- [Ansible](https://docs.ansible.com/ansible/latest/index.html) (`pip install ansible` or `pipx install --include-deps ansible`)


## Encrypting secrets with ansible-vault and git-crypt

Secrets should be encrypted with [ansible-vault](https://docs.ansible.com/ansible/latest/cli/ansible-vault.html). The password is inside `ansible-vault-key` file and this file is encrypted with [git-crypt](https://www.agwa.name/projects/git-crypt/).

This setup allows to:
- configure vault in `ansible.cfg`.
- manage access with a single file.

In this example repository there are no secrets in ansible-vault, but `ansible-vault-key` is created for demonstration.


## Testing with Vargant

- Install [vagrant](https://www.vagrantup.com/) (`sudo apt install vagrant` or whatever fits your distro)
- Run
    ```sh
    vagrant up
    ./play.sh
    ```
- Open in browser `http://ip-of-your-vm:443` (It's http on 443, because on vagrant https is disabled. On port 80 there is still a redirect to https.)
