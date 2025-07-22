{% if applied_filters %}
    
    {# Applied filters chips #}

    {% if has_applied_filters %}
        <div class="col-12 mb-3">
            <p class="d-md-inline-block mr-md-2 mb-2">{{ 'Filtrado por:' | translate }}</p>
            {% for product_filter in product_filters %}
                {% for value in product_filter.values %}

                    {# List applied filters as tags #}
                    
                    {% if value.selected %}
                        <button class="js-remove-filter chip" data-filter-name="{{ product_filter.key }}" data-filter-value="{{ value.name }}">
                            {{ value.pill_label }}
                            {% include "snipplets/svg/times.tpl" with {svg_custom_class: "icon-inline chip-remove-icon ml-2"} %}
                        </button>
                    {% endif %}
                {% endfor %}
            {% endfor %}
            <a href="#" class="js-remove-all-filters d-inline-block pl-1 mt-3">{{ 'Borrar filtros' | translate }}</a> 
        </div>
    {% endif %}
{% else %}
    {% if product_filters is not empty %}
        <div id="filters" data-store="filters-nav">
            {% for product_filter in product_filters %}
                {% if product_filter.type == 'price' %}

                    {{ component(
                        'price-filter',
                        {'group_class': 'filters-container mb-5', 'title_class': 'label-title mb-3', 'button_class': 'btn btn-default btn-small py-3 px-3 align-bottom' }
                    ) }}

                {% else %}
                    {% if product_filter.has_products %}
                        <div class="filters-container mb-5" data-store="filters-group">
                            <p class="label-title mb-3">{{product_filter.name}}</p>
                            {% set index = 0 %}
                            {% for value in product_filter.values %}
                                {% if value.product_count > 0 %}
                                    {% set index = index + 1 %}
                                    <label class="js-filter-checkbox {% if not value.selected %}js-apply-filter{% else %}js-remove-filter{% endif %} checkbox-container {% if mobile %}mb-3{% else %}mb-2{% endif %}" data-filter-name="{{ product_filter.key }}" data-filter-value="{{ value.name }}">
                                        <input type="checkbox" autocomplete='off' {% if value.selected %}checked{% endif %}>
                                        <span class="checkbox">
                                            {% if product_filter.type == 'color' and value.color_type == 'insta_color' %}
                                                <span class="checkbox-color" style="background-color: {{ value.color_hexa }};"></span>
                                            {% endif %}
                                            <span class="font-medium ml-2">{{ value.name }} ({{ value.product_count }})</span>
                                        </span>
                                    </label>
                                    {% if index == 8 and product_filter.values_with_products > 8 %}
                                        <div class="js-accordion-container" style="display: none;">
                                    {% endif %}
                                {% endif %}
                                {% if loop.last and product_filter.values_with_products > 8 %}
                                    </div>
                                    <a href="#" class="js-accordion-toggle btn-link d-table mt-3 pl-0">
                                        <span class="js-accordion-toggle-inactive">
                                            {{ 'Ver todos' | translate }}
                                        </span>
                                        <span class="js-accordion-toggle-active" style="display: none;">
                                            {{ 'Ver menos' | translate }}
                                        </span>
                                    </a>
                                {% endif %}
                            {% endfor %}
                        </div>
                    {% endif %}
                {% endif %}
            {% endfor %}
        </div>
    {% endif %}
{% endif %}