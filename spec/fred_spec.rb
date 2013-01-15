# TODO: test with RSpec

require 'spec_helper'

describe "Fred API" do
  let(:client) { Fred::Client.new(:api_key => 'wtf') }

  describe "using categories" do
    it "finds a specific category" do
      stub_get("http://api.stlouisfed.org/fred/category?category_id=125&api_key=wtf", "category.xml")
      category_result = client.category(nil, :category_id => '125')

      category_result.categories.category.name.should  eq("Trade Balance")
    end
  end

  describe "using releases" do
    it "finds all releases" do        # TODO: Some XML parsing error here...
      stub_get("http://api.stlouisfed.org/fred/releases?api_key=wtf", "releases.xml")
      releases_result = client.releases(nil)

      releases_result.first.last.release.first.name.should eq("Advance Monthly Sales for Retail and Food Services")
      releases_result.first.last.release.last.name.should eq("Wall Street Journal")
    end
  end

  describe "using release" do
    it "finds a specific release" do
      stub_get("http://api.stlouisfed.org/fred/release?release_id=53&api_key=wtf", "release.xml")
      release_result = client.release(nil, :release_id => "53")

      release_result.releases.release.name.should eq("Gross Domestic Product")
    end
  end

  describe "using series" do
    it "finds a specific series" do
      stub_get("http://api.stlouisfed.org/fred/series?api_key=wtf&series_id=GNPC", "series.xml")
      series_result = client.series(nil, :series_id => "GNPC")

      series_result.seriess.series.title.should eq("Real Gross National Product")
    end
  end

  describe "using source" do
    it "finds a specific source" do
      stub_get("http://api.stlouisfed.org/fred/source?source_id=1&api_key=wtf", "source.xml")
      source_result = client.source(nil, :source_id => "1")

      source_result.sources.source.name.should eq("Board of Governors of the Federal Reserve System")
    end
  end

  describe "using sources" do
    it "finds all sources" do          # TODO: Some XML parsing error here...
      stub_get("http://api.stlouisfed.org/fred/sources?&api_key=wtf&source_id=1", "sources.xml")
      sources_result = client.sources(nil, :source_id => "1")

      sources_result.sources.source.first.name.should eq("Board of Governors of the Federal Reserve System")
      sources_result.sources.source.last.name.should eq("Central Bank of the Republic of Turkey")
    end
  end

end
