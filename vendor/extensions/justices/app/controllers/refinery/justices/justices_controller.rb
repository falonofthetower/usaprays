module Refinery
  module Justices
    class JusticesController < ::ApplicationController

      before_filter :find_all_justices
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @justice in the line below:
        present(@page)
      end

      def show
        @justice = Justice.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @justice in the line below:
        present(@page)
      end

    protected

      def find_all_justices
        @justices = Justice.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/justices").first
      end

    end
  end
end
