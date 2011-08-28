require "twitter"

class Tweet < SuperModel::Base
  class << self
    def poll
      destroy_all
      timeline.each do |tweet|
        create(tweet)
      end
    end
    
    def update(status)
      twitter.update(status)
      poll
    end

    private
      def timeline
        twitter.user_timeline("jgwmaxwell").collect {|t|
          t.profile_image_url = t.user.profile_image_url
          t.delete('user')
          t.to_hash
        }
      end

      def twitter
        Twitter::Client.new
      end
  end
end