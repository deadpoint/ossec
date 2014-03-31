require 'spec_helper'

describe 'ossec::config::syscheck::dir' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { '/var/foo' }

  let (:params) { { :realtime => 'yes', :report_changes => 'yes', :check_all => 'yes', :name => "#{title}" } }

  let (:ossec_params_conf_file) { '/var/ossec/etc/ossec.conf' }

  it 'should contain a concat::fragment for setting the syscheck dir options' do
    should contain_concat__fragment("syscheck_dir_#{params[:name]}").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '13',
      'content' => "  <syscheck>\n    <directories realtime=\"#{params[:realtime]}\" report_changes=\"#{params[:report_changes]}\" check_all=\"#{params[:check_all]}\" >#{params[:name]}</directories>\n  </syscheck>\n\n",
  })

  end
end

