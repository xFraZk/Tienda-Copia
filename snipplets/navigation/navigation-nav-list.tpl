{% for item in navigation %}
    {% if item.subitems %}
        <li class="item-with-subitems">
            <a class="js-toggle-menu-panel nav-list-link align-items-center" href="#">
                {{ item.name }}
                <span class="nav-list-arrow">
                    {% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline icon-2x svg-icon-invert"} %}
                </span>
            </a>
            <ul class="js-menu-panel list-subitems nav-list-panel" style="display:none;">
                <a class="js-toggle-menu-back nav-list-arrow pt-1 pl-0" href="#">
                    {% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline icon-2x svg-icon-invert"} %}
                </a>
                <a class="js-toggle-menu-close nav-list-arrow pt-1 pr-0 d-md-block d-none float-right" href="#">
                    {% include "snipplets/svg/times.tpl" with {svg_custom_class: "icon-inline icon-2x svg-icon-invert"} %}
                </a>
                <div class="h2 my-4">{{ item.name }}</div>
                {% if item.isCategory %}
                    <li class="nav-item">
                        <a class="nav-list-link {{ item.current ? 'selected' : '' }}" href="{{ item.url }}">
                            {% if item.isRootCategory %}
                                {{ 'Ver todos los productos' | translate }}
                            {% else %}
                                {{ 'Ver todo en' | translate }} {{ item.name }}
                            {% endif %}
                        </a>
                    </li>
                {% endif %}
                {% snipplet "navigation/navigation-nav-list.tpl" with navigation = item.subitems %}
            </ul>
        </li>
    {% else %}
        <li>
            <a class="nav-list-link" href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}">{{ item.name }}</a>
        </li>
    {% endif %}
{% endfor %}