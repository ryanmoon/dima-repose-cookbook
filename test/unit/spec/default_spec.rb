require 'chefspec'
require_relative 'spec_helper'

describe 'dima-repose::default' do
  before { stub_resources }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(UBUNTU_OPTS).converge(described_recipe)
  end

  it 'includes the `java::oracle` recipe' do
    expect(chef_run).to include_recipe('java::oracle')
  end

  it 'includes the `repose::install` recipe' do
    expect(chef_run).to include_recipe('repose::install')
  end

  it 'includes the `repose::filter-header-normalization` recipe' do
    expect(chef_run).to include_recipe('repose::filter-header-normalization')
  end

  it 'includes the `repose::install_debian` recipe' do
    expect(chef_run).to include_recipe('repose::install_debian')
  end

  it 'includes the `apt::default` recipe' do
    expect(chef_run).to include_recipe('apt::default')
  end

  it 'includes the `apt::default` recipe' do
    expect(chef_run).to include_recipe('apt::default')
  end

  it 'populates /etc/repose/system-model.cfg.xml with default attrs' do
    expect(chef_run).to render_file(
      '/etc/repose/system-model.cfg.xml'
    ).with_content(include('<filter name="header-normalization" />'))
    expect(chef_run).to render_file(
      '/etc/repose/system-model.cfg.xml'
    ).with_content(include('<filter name="keystone-v2" />'))
    expect(chef_run).to render_file(
      '/etc/repose/system-model.cfg.xml'
    ).with_content(include('<filter name="url-extractor-to-header" />'))
  end

  it 'populates /etc/init/repose-valve.conf' do
    expect(chef_run).to render_file(
      '/etc/init/repose-valve.conf'
    )
  end

  it 'deletes /etc/init.d/repose-valve' do
    expect(chef_run).to delete_file(
      '/etc/init.d/repose-valve'
    )
  end

  it 'enables repose-valve service' do
    expect(chef_run).to enable_service('repose-valve')
  end
end
