{# Featured products that work as examples #}

{% set slide_item = slider ? 'true' : 'false' %}
{% set full_item = full_item_grid ? 'true' : 'false' %}
{% set arrow_class = settings.positive_color_background or title_outside ? 'svg-icon-invert' : 'svg-icon-text' %}

<section class="{% if title_outside %}section-category-home{% else %}section-featured-home{% endif %} px-2 px-md-3" data-store="home-products-{{ section_id }}">
	<div class="container-fluid position-relative">
		<div class="row align-items-center justify-content-between">
			<div class="{% if slider %}col-12{% else %}col-md-4{% if settings.positive_color_background %} container-invert{% endif %}{% endif %}">
				<h3 class="h1{% if title_outside %} text-secondary{% endif %}">{{ products_title }}</h3>
				{% if slider %}
					<div class="js-swiper-featured-demo-prev swiper-button-prev d-none d-md-block {{ arrow_class }}">
						{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline icon-2x mr-1"} %}
					</div>
					<div class="js-swiper-featured-demo-next swiper-button-next d-none d-md-block {{ arrow_class }}">
						{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline icon-2x ml-1"} %}
					</div>
				{% endif %}
			</div>
			<div class="{% if not slider %}col-md-6 pt-3 pt-md-5{% else %}col-12 pr-md-3 pr-0{% endif %}">
				{% if slider %}
					<div class="js-swiper-featured-demo swiper-container  p-1">
						<div class="swiper-wrapper">
				{% else %}
					<div class="row row-grid">
				{% endif %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_1': true, 'section_columns_desktop': 2, 'section_columns_mobile': 2, 'slide_item': slide_item, 'full_item': full_item_grid} %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_2': true, 'section_columns_desktop': 2, 'section_columns_mobile': 2, 'slide_item': slide_item, 'full_item': full_item_grid} %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_3': true, 'section_columns_desktop': 2, 'section_columns_mobile': 2, 'slide_item': slide_item, 'full_item': full_item_grid} %}
					{% if slider %}
						{% include 'snipplets/defaults/help_item.tpl' with {'help_item_4': true, 'section_columns_desktop': 2, 'section_columns_mobile': 2, 'slide_item': slide_item, 'full_item': full_item_grid} %}
					{% endif %}
					{% if slider %}
						</div>
					{% endif %}
				</div>
			</div>
		</div>
		{% if slider and not settings.positive_color_background and title_outside %}
			<div class="section-category-home-background"></div>
		{% endif %}
	</div>
</section>
