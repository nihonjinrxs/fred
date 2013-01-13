module Fred
  
  class Client
    include HTTParty
    base_uri "http://api.stlouisfed.org/fred"
    format :xml
        
    attr_reader :api_key
                
    def initialize(options={})
      @api_key = options[:api_key] || Fred.api_key
    end

    def category(secondary, options={})
      if secondary.nil?
        mashup(self.class.get("/category", :query => options.merge(self.default_options)))
      else
        mashup(self.class.get("/category/#{secondary}", :query => options.merge(self.default_options)))			
      end
    end
    
    def releases(secondary, options={})
      if secondary.nil?
        mashup(self.class.get("/releases", :query => options.merge(self.default_options)))
      else
        mashup(self.class.get("/releases/#{secondary}", :query => options.merge(self.default_options)))			
      end
    end
    
    def release(secondary, options={})
      if secondary.nil?
        mashup(self.class.get("/release", :query => options.merge(self.default_options)))
      else
        mashup(self.class.get("/release/#{secondary}", :query => options.merge(self.default_options)))			
      end
    end
    
    def series(secondary, options={})
      if secondary.nil?
        mashup(self.class.get("/series", :query => options.merge(self.default_options)))
      else
        mashup(self.class.get("/series/#{secondary}", :query => options.merge(self.default_options)))			
      end
    end
    
    def sources(secondary, options={})
      if secondary.nil?
        mashup(self.class.get("/sources?", :query => options.merge(self.default_options)))
      else
        mashup(self.class.get("/sources/#{secondary}", :query => options.merge(self.default_options)))			
      end
    end
    
    def source(secondary, options={})
      if secondary.nil?
        mashup(self.class.get("/source", :query => options.merge(self.default_options)))
      else
        mashup(self.class.get("/source/#{secondary}", :query => options.merge(self.default_options)))			
      end
    end
    
    protected
    
    def default_options
      {:api_key => @api_key}
    end
    
    def mashup(response)
      case response.code
      when 200
        if response.is_a?(Hash)
          Hashie::Mash.new(response)
        else
          if response.first.is_a?(Hash)
            response.map{|item| Hashie::Mash.new(item)}
          else
            response
          end
        end
      end
    end

  end

  class SimpleClient < Client
    # Categories (fred/category/...)
    alias :_category :category

    def category(options={})
      _category nil, *options
    end
    alias :categories :category

    def category_children(options={})
      _category :children, *options
    end

    def category_related(options={})
      _category :related, *options
    end

    def category_series(options={})
      _category :series, *options
    end

    # Releases (fred/releases/...)
    alias :_releases :releases

    def releases(options={})
      _releases nil, *options
    end

    def releases_dates(options={})
      _releases :dates, *options
    end

    # Release (fred/release/...)
    alias :_release :release

    def release(options={})
      _release nil, *options
    end

    def release_dates(options={})
      _release :dates, *options
    end

    def release_series(options={})
      _release :series, *options
    end

    def release_sources(options={})
      _release :sources, *options
    end

    # Series (fred/series/...)
    alias :_series :series

    def series(options={})
      _series nil, *options
    end

    def series_categories(options={})
      _series :categories, *options
    end

    def series_observations(options={})
      _series :observations, *options
    end

    def series_release(options={})
      _series :release, *options
    end

    def series_search(options={})
      _series :search, *options
    end

    def series_updates(options={})
      _series :updates, *options
    end

    def series_vintage(options={})
      _series :vintagedates, *options
    end

    # Sources (fred/sources/...)
    alias :_sources :sources

    def sources(options={})
      _sources nil, *options
    end

    # Series (fred/source/...)
    alias :_source :source

    def source(options={})
      _source nil, *options
    end

    def source_releases(options={})
      _source :releases, *options
    end
  end
end