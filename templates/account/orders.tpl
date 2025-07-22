{% embed "snipplets/page-header.tpl" %}
    {% block page_header_text %}{{ "Mi cuenta" | translate }}{% endblock page_header_text %}
{% endembed %}

<section class="account-page container-invert pl-2 px-md-3">
    <div class="container-fluid">
        <div class="row pt-3">
            <div class="col">
                <ul class="js-tab-nav tab-nav mb-4">
                    <li class="tab-nav-item  {% if loop.first %} tab-active{% endif %}">
                        <a class="tab-nav-link tab-nav-link-inverse link-contrast" href="#tab_customer_shop">{{ 'Mis compras' | translate }}</a>
                    </li>
                    <li class="tab-nav-item">
                        <a class="tab-nav-link tab-nav-link-inverse link-contrast" href="#tab_customer_data">{{ 'Mis datos' | translate }}</a>
                    </li>
                </ul>
                <div id="tab_customer_shop" class="js-tab-stage tab-stage-item margin-bottom-negative">
                    <div class="row mt-3" data-store="account-orders">
                        {% if customer.orders %}
                            <div class="col">
                                <div class="section-account-background"></div>
                                <div class="row">
                                    {% if customer.ordersCount > 50 %}
                                        <div class="col-12 mb-2 font-small">
                                            {{ 'Últimas 50 órdenes' | translate }}
                                        </div>
                                    {% endif %}
                                    {% for order in customer.orders %}
                                        {% set add_checkout_link = order.pending %}
                                        <div class="col-lg-4 {% if order.shipping_status == 'fulfilled' %} card-gray-scale {% endif %}" data-store="account-order-item-{{ order.id }}">
                                            {% embed "snipplets/card.tpl" with{card_footer: true, card_custom_class: (order.shipping_status == 'fulfilled' ? 'card-collapse card-gray-scale card-invert' : 'card-collapse card-invert'), card_active: card_active, card_collapse: true} %}
                                                {% block card_body %}
                                                    <div class="row mb-4">
                                                        <div class="col-6">
                                                            <div class="card-img-square-container">
                                                                {% for item in order.items %}
                                                                    {% if loop.first %} 
                                                                        {% if loop.length > 1 %} 
                                                                            <span class="card-img-pill label label-secondary mb-0">{{ loop.length }} {{'Productos' | translate }}</span>
                                                                        {% endif %}
                                                                        {{ item.featured_image | product_image_url("") | img_tag(item.featured_image.alt, {class: 'card-img-square card-img-square img-absolute img-absolute-centered'}) }}
                                                                    {% endif %}
                                                                {% endfor %}
                                                            </div>
                                                        </div>
                                                        <div class="col pl-2">
                                                            <a class="btn-link text-primary font-weight-bold pr-4" href="{{ store.customer_order_url(order) }}">{{'Orden' | translate}} #{{order.number}} </a>  
                                                            <p class="mb-1 font-small">{{ order.date | i18n_date('%d/%m/%Y') }}</p>
                                                            <p class="mb-1 font-small">
                                                                {{'Pago' | translate}}: <span class="{{ order.payment_status }}">{{ (order.payment_status == 'pending'? 'Pendiente' : (order.payment_status == 'authorized'? 'Autorizado' : (order.payment_status == 'paid'? 'Pagado' : (order.payment_status == 'voided'? 'Cancelado' : (order.payment_status == 'refunded'? 'Reintegrado' : 'Abandonado'))))) | translate }}</span>
                                                            </p>
                                                            <p class="mb-2 font-small">
                                                                {{'Envío' | translate}}: {{ (order.shipping_status == 'fulfilled'? 'Enviado' : 'No enviado') | translate }}
                                                            </p>
                                                            <p class="mb-1 font-small">
                                                                <strong>{{'Total' | translate}}: {{ order.total | money }}</strong>
                                                            </p>
                                                            <a class="btn-link" href="{{ store.customer_order_url(order) }}">{{'Ver detalle' | translate}}</a>
                                                        </div>
                                                    </div>
                                                {% endblock %}
                                                {% block card_foot %}
                                                    {% if add_checkout_link %}
                                                        <a class="btn btn-primary d-block mt-3" href="{{ order.checkout_url | add_param('ref', 'orders_list') }}" target="_blank">{{'Realizar pago' | translate}}</a>
                                                    {% elseif order.order_status_url != null %}
                                                        <a class="btn btn-primary d-block mt-3" href="{{ order.order_status_url | add_param('ref', 'orders_list') }}" target="_blank">{% if 'Correios' in order.shipping_name %}{{'Seguí la entrega' | translate}}{% else %}{{'Seguí tu orden' | translate}}{% endif %}</a>
                                                    {% endif %}
                                                {% endblock %}
                                            {% endembed %}
                                        </div>
                                    {% endfor %}
                                </div>
                            </div>
                        {% else %}
                            <div class="col mb-5">
                                {% include "snipplets/svg/shopping-bag.tpl" with {svg_custom_class: "icon-inline icon-lg svg-icon-text"} %}
                                <p class="mb-4">{{ '¡Hacé tu primera compra!' | translate }}</p>
                                {{ 'Ir a la tienda' | translate | a_tag(store.url, '', 'btn btn-stroke-gradient d-inline-block mb-3') }}
                            </div>
                        {% endif %}
                    </div>
                </div>
                <div id="tab_customer_data" class="js-tab-stage tab-stage-item{% if loop.first %} tab-stage-active{% endif %} text-left container-invert row">
                    <div class="col-md-6    ">
                        <p class="label-title mb-3">{{ 'Datos personales' | translate }}</p>
                        <p class="mb-5">
                            <span class="d-block font-weight-light mb-2">
                                {{ customer.name }}
                            </span>
                            <span class="d-block font-weight-light mb-2">
                                {{ customer.email }}
                            </span>
                            {% if customer.cpf_cnpj %}
                                <span class="d-block font-weight-light mb-2">
                                    {{ customer.cpf_cnpj | format_id_number(customer.billing_country) }}
                                </span>
                            {% endif %}

                            {% if customer.business_name %}
                                <span class="d-block font-weight-light mb-2">
                                    {{ 'Razón social' | translate }}: {{ customer.business_name }}
                                </span>
                            {% endif %}
                            {% if customer.trade_name %}
                                <span class="d-block font-weight-light mb-2">
                                    {{ 'Nombre comercial' | translate }}: {{ customer.trade_name }}
                                </span>
                            {% endif %}
                            {% if customer.state_registration %}
                                <span class="d-block font-weight-light mb-2">
                                    {{ 'Inscripción estatal' | translate }}: {{ customer.state_registration }}
                                </span>
                            {% endif %}
                            {# Giro business activity used only by CL stores #}
                            {% if customer.business_activity %}
                                <span class="d-block font-weight-light mb-2">
                                    {{ 'Giro' | translate }}: {{ customer.business_activity }}
                                </span>
                            {% endif %}
                            {% if customer.fiscal_regime %}
                                <span class="d-block font-weight-light mb-2">
                                    {{ 'Régimen fiscal' | translate }}: {{ customer.fiscal_regime | format_fiscal_regime }}
                                </span>
                            {% endif %}

                            {% if customer.phone %}
                                <span class="d-block font-weight-light mb-3">
                                    {{ customer.phone }}
                                </span>
                            {% endif %}
                            <span class="d-inline-block mt-3">
                                {{ 'Editar mis datos' | translate | a_tag(store.customer_info_url, '', 'btn btn-stroke-gradient') }}
                            </span>
                        </p>
                    </div>
                    <div class="col-md-6">  
                        {% if customer.default_address %}
                            <p class="label-title mb-3">{{ 'Mis direcciones' | translate }}</p>
                            <p class="mb-5">
                                <strong class="d-block">
                                    {{ 'Principal' | translate }}
                                </strong>
                                <span class="d-block font-weight-light mb-2">
                                    {{ customer.default_address | format_address_short }}
                                </span>
                                <span class="d-inline-block mt-3">
                                    {{ 'Editar mis direcciones' | translate | a_tag(store.customer_address_url(customer.default_address), '', 'btn btn-stroke-gradient') }}
                                </span>
                            </p>
                        {% endif %}
                    </div> 
                </div>
            </div>
        </div>
    </div>
</section>
