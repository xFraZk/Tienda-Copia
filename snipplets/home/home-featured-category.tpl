{% if category.products %}
    <h3 class="h1 text-secondary">{{ category.name }}</h3>
    {% if categories %}
        <ul class="js-tab-nav tab-group tab-nav mb-1 w-100">
            {% for category in categories %}
                {% if category.products %}
                    <li class="tab-nav-item mb-3{% if loop.first %} tab-active{% endif %}">
                        <a class="tab-nav-link tab-nav-link-inverse link-contrast" href="#tab_{{ loop.index }}">{{ category.name }}</a>
                    </li>
                {% endif %}
            {% endfor %}
        </ul>
        <div class="tab-stage">
            {% for category in categories %}
                {% if category.products %}
                    <div id="tab_{{ loop.index }}" class="js-tab-stage tab-stage-item{% if loop.first %} tab-stage-active{% endif %}">
                        <div class="js-swiper-category{{ loop.index }} swiper-container p-1">
                            <div class="swiper-wrapper">
                                {% for product in category.products %}
                                    {% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'section_name': section_name} %}
                                {% endfor %}
                            </div>
                        </div>
                        <div class="js-swiper-category{{ loop.index }}-prev swiper-button-prev d-none d-md-block svg-icon-invert">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline icon-2x mr-1"} %}</div>
                        <div class="js-swiper-category{{ loop.index }}-next swiper-button-next d-none d-md-block svg-icon-invert">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline icon-2x ml-1"} %}</div>
                    </div>
                {% endif %}
            {% endfor %}
        </div>
    {% else %}
        <div class="js-swiper-category swiper-container p-1">
            <div class="swiper-wrapper">
                {% for product in category.products %}
                    {% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'section_name': section_name} %}
                {% endfor %}
            </div>
        </div>
        <div class="js-swiper-category-prev swiper-button-prev d-none d-md-block svg-icon-invert">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline icon-2x mr-1"} %}</div>
        <div class="js-swiper-category-next swiper-button-next d-none d-md-block svg-icon-invert">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline icon-2x ml-1"} %}</div>
    {% endif %}
    {% if not settings.positive_color_background %}
        <div class="section-category-home-background"></div>
    {% endif %}
{% endif %}
