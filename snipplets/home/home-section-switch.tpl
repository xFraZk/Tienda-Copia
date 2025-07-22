{% if section_select == 'slider' %}

	{#  **** Home slider ****  #}
	<section class="position-relative" data-store="home-slider">
		{% if show_help or (show_component_help and not (has_main_slider or has_mobile_slider)) %}
			{% include 'snipplets/defaults/home/slider_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-slider.tpl' %}
			{% if has_mobile_slider %}
				{% include 'snipplets/home/home-slider.tpl' with {mobile: true} %}
			{% endif %}
		{% endif %}
	</section>

{% elseif section_select == 'banners' %}

	{#  **** Categories banners ****  #}
	{% if show_help or (show_component_help and not has_category_banners) %}
		{% include 'snipplets/defaults/home/banners_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-banners.tpl' %}
	{% endif %}

{% elseif section_select == 'products' %}

	{#  **** Featured products ****  #}
	{% if show_help or (show_component_help and not has_products) %}
		{% include 'snipplets/defaults/home/featured_products_help.tpl' with { 
			products_title: 'Productos destacados' | translate, 
			section_id: 'featured', 
			full_item_grid: true }
		%}
	{% else %}
		{% include 'snipplets/home/home-featured-products.tpl' with {'has_featured': true} %}
	{% endif %}

{% elseif section_select == 'brands' %}

	{#  **** Brands slider ****  #}
	{% if show_help or (show_component_help and not has_brands) %}
		{% include 'snipplets/defaults/home/brands_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-brands.tpl' %}
	{% endif %}

{% elseif section_select == 'category' %}

	{#  **** Category products ****  #}
	{% if show_help or (show_component_help and not has_category_products) %}
		{% include 'snipplets/defaults/home/featured_products_help.tpl' with { 
			products_title: 'Categoría' | translate, 
			section_id: 'category',
			title_outside: true,
			slider: true }
		%}
	{% else %}
		{% include 'snipplets/home/home-featured-products.tpl' with {'has_category': true} %}
	{% endif %}

{% elseif section_select == 'video' %}

	{#  **** Video embed ****  #}
	{% if show_help or (show_component_help and not has_video) %}
		{% snipplet 'defaults/home/video_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-video.tpl' %}
	{% endif %}

{% elseif section_select == 'informatives' %}

	{#  **** Informative banners ****  #}
	{% if show_help or (show_component_help and not has_informative_banners) %}
		{% snipplet 'defaults/home/informative_banners_help.tpl' %}
	{% else %}
		{% include 'snipplets/banner-services/banner-services.tpl' %}
	{% endif %}

{% elseif section_select == 'sale' %}

	{#  **** Sale products ****  #}
	{% if show_help or (show_component_help and not has_products) %}
		{% include 'snipplets/defaults/home/featured_products_help.tpl' with { 
			products_title: 'Ofertas' | translate, 
			section_id: 'sale',
			slider: true }
		%}
	{% else %}
		{% include 'snipplets/home/home-featured-products.tpl' with {'has_sale': true} %}
	{% endif %}

{% elseif section_select == 'instafeed' %}

	{#  **** Instafeed ****  #}
	{% if show_help or (show_component_help and not has_instafeed) %}
		{% snipplet 'defaults/home/instafeed_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-instafeed.tpl' %}
	{% endif %}

{% endif %}