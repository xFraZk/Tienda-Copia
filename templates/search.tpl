{% paginate by 12 %}

{% embed "snipplets/page-header.tpl" with { breadcrumbs: false } %}
	{% block page_header_text %}{{ "Resultados de búsqueda" | translate }}{% endblock page_header_text %}
{% endembed %}

<section class="category-body px-2 px-md-3">
	<div class="container-fluid">
		{% if products %}
	        <div class="js-product-table row">
	        	{% include 'snipplets/product_grid.tpl' %}
	        </div>
			{% include 'snipplets/grid/pagination.tpl' with {'pages': pages, 'infinite_scroll': true } %}
		{% else %}
	        <h2 class="text-center h-font-body">
	            {{ "No hubo resultados para tu búsqueda" | translate }}
	        </h2>
	    {% endif %}
	</div>
</section>