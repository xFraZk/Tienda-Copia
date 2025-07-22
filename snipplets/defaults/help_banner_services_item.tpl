<div class="col-md text-center mb-4 m-md-0">
	{% if help_item_1 %}
		{% set help_item_title = 'Medios de envío' | translate %}
		{% set help_item_icon = 'map-marker.tpl' %}
	{% elseif help_item_2 %}
		{% set help_item_title = 'Tarjetas de crédito' | translate %}
		{% set help_item_icon = 'credit-card.tpl' %}
	{% else %}
		{% set help_item_title = 'Sitio seguro' | translate %}
		{% set help_item_icon = 'lock.tpl' %}
	{% endif %}
	{% include "snipplets/svg/" ~ help_item_icon with {svg_custom_class: "icon-inline icon-5x svg-icon-text my-3"} %}
	<h3 class="h2 mb-2">{{ help_item_title }}</h3>
</div>