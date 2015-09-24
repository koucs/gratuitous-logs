class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    # sometokenの所に元々のトークンをセット（よくわからない）
    GratuitousLog::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || 'sometoken'

    before_action :prepare_meta_tags, if: "request.get?"

    # meta tagsの初期設定
    # コントローラからの呼び出しで初期値の設定
    def prepare_meta_tags(options={})
        puts options
        site = "WevSTAT by kou_cs"
        title = [controller_name, action_name].join(" ")
        description = "kou_csのRuby on Rails等の技術メモ、機械学習の勉強過程をブログにまとめています。"
        image = options[:image] || "your-default-image-url"
        current_url = request.url

        # Let's prepare a nice set of defaults

        defaults = {
          site: site,
          title: title,
          image: image,
          description: description,
          keywords: "Webデザイン,Ruby,Rails,機械学習,Python,英語,資格勉強",
          twitter: {
            site_name: site,
            site: '@kou_cs',
            card: 'summary',
            description: description,
            image: image
          },
          og: {
            url: current_url,
            site_name: site,
            title: title,
            image: image,
            description: description,
            type: 'website'
          }
        }

        options.reverse_merge!(defaults)
        set_meta_tags options
    end
end
