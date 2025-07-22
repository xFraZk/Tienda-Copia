{% if primary_links %}
    <div class="js-nav-primary nav-primary">
        <ul class="nav-list" data-store="navigation">
            {% snipplet "navigation/navigation-nav-list.tpl" %}
        </ul>
    </div>
    {% if mobile %}
        {% snipplet "navigation/navigation-lang-social.tpl" %}
    {% endif %}
{% else %}
    <div class="nav-secondary {% if not mobile %}pt-3 pb-md-5{% endif %}">
        {% if not mobile %}
            {% snipplet "navigation/navigation-lang-social.tpl" %}
        {% endif %}
        <ul class="nav-account{% if customer %} nav-account-invert{% endif %} row" data-store="account-links">
            {% if not customer %}
                {% if 'mandatory' not in store.customer_accounts %}
                <li class="nav-account-item col-auto p-0">{{ "Crear cuenta" | translate | a_tag(store.customer_register_url, '', 'nav-account-link') }}</li>
                {% endif %}
                <li class="nav-account-item col">{{ "Ingresar" | translate | a_tag(store.customer_login_url, '', 'nav-account-link') }}</li>
            {% else %}
                {% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
                <li class="nav-account-item col-8 p-0">{{ "¡Hola, {1}!" | t(customer_short_name) | a_tag(store.customer_home_url, {class: 'nav-account-link nav-account-link-invert'}) }}</li>
                <li class="nav-account-item col-4">{{ "Salir" | translate | a_tag(store.customer_logout_url, '', 'nav-account-link nav-account-link-invert') }}</li>
            {% endif %}
        </ul>
    </div>
{% endif %}