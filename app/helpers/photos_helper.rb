# frozen_string_literal: true

module PhotosHelper
  def metadata_table_rows( photo )
    return unless photo.metadata.present?

    transform_metadata( photo.visible_metadata( current_user ) ).each do | k, v |
      concat( content_tag( :tr ) { content_tag( :th, k ) + content_tag( :td, v, class: "ui" ) } )
    end
  end

  private

  def transform_metadata( metadata )
    metadata.map do | k, v |
      new_key = k.to_s.humanize.gsub /Gps/, "GPS"
      new_val = case v
      when String then formatted_user_text( v.utf_safe )
      else v
      end
      [new_key, new_val]
    end.to_h
  end
end
