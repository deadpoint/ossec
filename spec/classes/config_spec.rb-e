require 'spec_helper'

describe 'ossec::config' do

  let :facts do {
    :concat_basedir => '/foo',
  }
  end

  let :pre_condition do
    'include ossec::params'
  end

  let (:params) { { :install_type => 'client' } }

  let (:ossec_params_conf_file) { '/var/ossec/etc/ossec.conf' }

  let (:ossec_params_group) { 'ossec' }

  it 'should contain concat::setup' do
    should contain_concat__setup
  end

  context 'install type not set properly' do
    let (:params) { { :install_type => 'blah' } }

    it 'should complain if $ossec::config::install_type is not set to client or server' do
      expect{ should compile }.to raise_error(Puppet::Error, /Invalid install_type, \[#{params[:install_type]}\], the value must be client or server/)
    end
  end

  it 'should contain a yumrepo for the atomic repo' do
    should contain_yumrepo('atomic').with({
      'name' => 'atomic',
      'descr' => 'CentOS / Red Hat Enterprise Linux $releasever - atomicrocketturtle.com',
      'mirrorlist' => 'http://updates.atomicorp.com/channels/mirrorlist/atomic/centos-$releasever-$basearch',
      'enabled'    => '1',
      'priority'   => '1',
      'protect'    => '0',
      'gpgcheck'   => '1',
      'gpgkey'     => 'file:////etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt',
      'before'     => 'Package[ossec]',
    })
  end

  it 'should manage a file resource for the atomic gpg key' do
    should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt').with({
      'ensure'  => 'present',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0644',
      'source'  => 'puppet:///modules/ossec/RPM-GPG-KEY.art.txt',
      'before'  => 'Yumrepo[atomic]',
    })
  end

  it 'should contain an exec to import the gpg key' do
    should contain_exec('import-gpg-key-ossec').with({
      'command'   => '/bin/rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt',
      'unless'    => '/bin/rpm -q gpg-pubkey-`(/usr/bin/gpg --throw-keyids < /etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt) | /bin/cut --characters=12-19 | /usr/bin/tr [A-Z] [a-z]`',
      'logoutput' => 'on_failure',
      'require'   => 'File[/etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt]',
      'before'    => 'Yumrepo[atomic]',
    })
  end

  it 'should contain a concat to manage the configuration file' do
    should contain_concat("#{ossec_params_conf_file}").with({
      'owner'   => 'root',
      'group'   => "#{ossec_params_group}",
      'mode'    => '0644',
      'require' => 'Package[ossec]',
      'notify'  => 'Class[Ossec::Service]',
    })
  end

  it 'should contain a concat fragment for adding the ossec config file header' do
    should contain_concat__fragment('ossec_header').with({
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '01',
    })
  end

  it 'should contain a concat fragment for adding the ossec config file footer' do
    should contain_concat__fragment('ossec_footer').with({
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '9999',
    })
  end

  context 'install type set to server' do

    let :facts do {
      :concat_basedir => '/foo',
    }
    end

    let :pre_condition do
      'include ossec::params'
    end

    let (:params) { { :install_type => 'server' } }

    let (:ossec_params_conf_file) { '/var/ossec/etc/ossec.conf' }

    it 'should contain a concat::fragment for the rules beginning' do
      should contain_concat__fragment('ossec_rules_begin').with({
        'target'  => "#{ossec_params_conf_file}",
        'order'   => '2000',
      })
    end

    it 'should contain a concat::fragment for the rules end' do
      should contain_concat__fragment('ossec_rules_end').with({
        'target'  => "#{ossec_params_conf_file}",
        'order'   => '2999',
      })
    end
  end
end

