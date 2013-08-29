class BlogController < ApplicationController
  def index
	@posts = BlogPost.where(:status_id => 2).paginate(:page => params[:page], :per_page => 5)
	#@posts = BlogPost.paginate :page => params[:page]

	@select = 'DISTINCT date_format(created_at,"%Y") as post_year, date_format(created_at,"%m") as post_month, date_format(created_at,"%b") as month_name'
	
	@past_dates = BlogPost.find(:all, :select => @select, :order => 'date_format(created_at,"%Y") desc, date_format(created_at,"%m") desc')

	@title = 'Blog'

	add_breadcrumb "Blog", ""
  end

  def post


	@year = params[:year]
	@month = params[:month]
	@slug = params[:slug]

	@post = BlogPost.where('date_format(created_at,"%Y") = ?',@year.to_i).where('date_format(created_at,"%m") = ?', @month.to_i).where(:slug => @slug).first


	cookies[:visitor] = PageViewProcess.process_page_view('blog_post', @post.id, cookies[:visitor], request.env["HTTP_USER_AGENT"])
	

	@select = 'DISTINCT date_format(created_at,"%Y") as post_year, date_format(created_at,"%m") as post_month, date_format(created_at,"%b") as month_name'

	@past_dates = BlogPost.find(:all, :select => @select, :order => 'date_format(created_at,"%Y") desc, date_format(created_at,"%m") desc')
	
	@title = 'Blog  - ' + @post.title

	add_breadcrumb 'Blog', '/blog'
	add_breadcrumb @post.title, ""

  end

  def archive

	@year = params[:year]
	@month = params[:month]
	@posts = BlogPost.where(:status_id => 2).where('date_format(created_at,"%Y") = ?',@year.to_i).where('date_format(created_at,"%m") = ?', @month.to_i).paginate(:page => params[:page], :per_page => 5)

	@select = 'DISTINCT date_format(created_at,"%Y") as post_year, date_format(created_at,"%m") as post_month, date_format(created_at,"%b") as month_name'
	@past_dates = BlogPost.find(:all, :select => @select, :order => 'date_format(created_at,"%Y") desc, date_format(created_at,"%m") desc')

	@title = 'Blog Archive'

	add_breadcrumb 'Blog', '/blog'
	add_breadcrumb "Archive", request.fullpath

  end

  def feed
    @posts = BlogPost.where(:status_id => 2).select("title, name as author, id, description as content, created_at, slug").order("created_at DESC").limit(20) 

    respond_to do |format|
      format.html
      format.rss { render :layout => false } #index.rss.builder
    end
  end
end
