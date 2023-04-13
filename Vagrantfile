# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = [
  {
    "name" => "testvm",
    "box" => "generic/ubuntu2204",
  },
]

Vagrant.configure("2") do |config|
  config.ssh.forward_agent = true

  boxes.each do |i|
    config.vm.define i['name'] do |testvm|
      testvm.vm.box = i['box']

      testvm.trigger.after [:up, :resume] do |trigger|
        trigger.info = "Updating ssh config..."
        trigger.run = {inline: "./vagrant_ssh_config_update.sh add #{i['name']}"}
      end

      testvm.trigger.before [:halt, :destroy, :suspend] do |trigger|
        trigger.info = "Cleaning up ssh config..."
        trigger.run = {inline: "./vagrant_ssh_config_update.sh remove #{i['name']}"}
      end
    end
  end
end
