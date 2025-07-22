{% if quickshop and product.variations | length == 1 %}
	{% set form_group_class = 'mb-0 mb-md-4' %}
{% else %}
	{% set form_group_class = '' %}
{% endif %}

{% if not quickshop and settings.bullet_variants %}
    {% set hidden_variant_select = ' d-none' %}
{% endif %}

{% for variation in product.variations %}
    
    {% if not quickshop %}
        {% set is_hidden_select = false %}
        {% if settings.image_color_variants and not (settings.bullet_variants)  %}
            {% if variation.name in ['Color', 'Cor'] %}
                {% set hidden_variant_select = ' d-none' %}
                {% set is_hidden_select = true %}
            {% else %}
                {% set hidden_variant_select = ' d-block' %}
            {% endif %}
        {% endif %}
    {% endif %}

    {% set is_button_variant = not quickshop and (settings.bullet_variants or (settings.image_color_variants and variation.name in ['Color', 'Cor'])) %}

    <div class="js-product-variants-group {% if variation.name in ['Color', 'Cor'] %}js-color-variants-container{% endif %} {% if quickshop %}{% if loop.length == 3 %}  col-md-2{% endif %} {% if loop.length == 2 or loop.length == 3 %} col-6 {% else %} col col-md{% endif %}{% else %}{% if settings.bullet_variants or settings.image_color_variants %}col-12{% else %}col-6{% endif %}{% endif %}" data-variation-id="{{ variation.id }}">
        {% embed "snipplets/forms/form-select.tpl" with{select_label: true, select_label_name: '' ~ variation.name ~ '', select_for: 'variation_' ~ loop.index, select_id: 'variation_' ~ loop.index, select_data: 'variant-id', select_data_value: 'variation_' ~ loop.index, select_name: 'variation' ~ '[' ~ variation.id ~ ']', select_group_custom_class: form_group_class ~ hidden_variant_select, select_custom_class: 'js-variation-option js-refresh-installment-data'} %}
            {% block select_options %}
                {% for option in variation.options %}
                    <option value="{{ option.id }}" {% if product.default_options[variation.id] is same as(option.id) %}selected="selected"{% endif %}>{{ option.name }}</option>
                {% endfor %}
            {% endblock select_options%}
        {% endembed %}
        {% if is_button_variant %}
            <div class="form-group mb-2">
                <label class="form-label">{{ variation.name }}: <strong class="js-insta-variation-label">{{ product.default_options[variation.id] }}</strong></label>
                {% for option in variation.options %}
                    <a data-option="{{ option.id }}" class="js-insta-variant btn btn-variant{% if product.default_options[variation.id] is same as(option.id) %} selected{% endif %}{% if variation.name in ['Color', 'Cor'] %} {% if option.custom_data or settings.image_color_variants %}btn-variant-color{% endif %}{% endif %}" title="{{ option.name }}" data-option="{{ option.id }}" data-variation-id="{{ variation.id }}">
                        <span class="btn-variant-content {% if settings.image_color_variants and variation.name in ['Color', 'Cor'] %} btn-variant-content-square{% endif %}"{% if option.custom_data and variation.name in ['Color', 'Cor'] and (settings.bullet_variants and not settings.image_color_variants) %} style="background: {{ option.custom_data }}; border: 1px solid #eee"{% endif %} data-name="{{ option.name }}">
                            {% if settings.image_color_variants and variation.name in ['Color', 'Cor'] %}
                                {% if product.default_options[variation.id] is same as(option.id) %}
                                    <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ product.featured_variant_image | product_image_url('thumb')}}" data-sizes="auto" class="lazyload img-absolute-centered-vertically" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
                                {% else %}
                                    {% for variant in product.variants if (variant.option1 == option.id) or (variant.option2 == option.id) or (variant.option3 == option.id) %}
                                        {% if loop.first %}
                                            <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ variant.image | product_image_url('thumb') }}" data-sizes="auto" class="lazyload img-absolute-centered-vertically" />
                                        {% endif %}
                                    {% endfor %}
                                {% endif %}
                            {% endif %}
                            {% if not(variation.name in ['Color', 'Cor']) or ((variation.name in ['Color', 'Cor']) and not option.custom_data and not settings.image_color_variants) %}
                                {{ option.name }}
                            {% endif %}
                        </span>
                    </a>
                {% endfor %}
            </div>
        {% endif %}
    </div>
{% endfor %}
