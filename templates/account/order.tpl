{% embed "snipplets/page-header.tpl" %}
    {% block page_header_text %}{{ 'Orden {1}' | translate(order.number) }}{% endblock page_header_text %}
{% endembed %}

<section class="account-page section-order-background px-2 px-md-3">
    <div class="container-fluid" data-store="account-order-detail-{{ order.id }}">
        <div class="row pt-3">
            <div class="col-md-4">
                {% if log_entry %}
                    <h4 class="h5 mb-3">{{ 'Estado actual del envío' | translate }}:</h4>{{ log_entry }}
                {% endif %}
                <p class="font-weight-light mb-5">
                    <span class="d-block">
                        {{'Fecha' | translate}}: {{ order.date | i18n_date('%d/%m/%Y') }}
                    </span>
                    <span class="d-block">
                        {{'Estado' | translate}}: {{ (order.status == 'open'? 'Abierta' : (order.status == 'closed'? 'Cerrada' : 'Cancelada')) | translate }}
                    </span>
                    <span class="d-block">
                        {{'Pago' | translate}}:{{ (order.payment_status == 'pending'? 'Pendiente' : (order.payment_status == 'authorized'? 'Autorizado' : (order.payment_status == 'paid'? 'Pagado' : (order.payment_status == 'voided'? 'Cancelado' : (order.payment_status == 'refunded'? 'Reintegrado' : 'Abandonado'))))) | translate }}
                    </span>
                    <span class="d-block">
                        {{'Medio de pago' | translate}}: {{ order.payment_name }}
                    </span>
                    {% if order.address %}
                        <span class="d-block">
                            {{'Envío' | translate}}: {{ (order.shipping_status == 'fulfilled'? 'Enviado' : 'No enviado') | translate }}
                        </span>
                        <span class="d-block">
                            {{ 'Dirección de envío' | translate }}:
                            <span class="d-block">
                                {{ order.address | format_address }}
                            </span>
                        </span>
                    {% endif %}
                </p>
            </div>
            <div class="col-md-7">
                {% block card_body %}
                    {% for item in order.items %}
                        <div class="card-invert p-0">
                            <div class="row no-gutters">
                                <div class="col-auto">
                                    <div class="card-img-square-container  card-img-square-container-order">
                                        {{ item.featured_image | product_image_url("small") | img_tag(item.featured_image.alt, {class: 'card-img-order'}) }}
                                    </div>
                                </div>
                                <div class="col">
                                    <p class="p-3">
                                        <strong>{{ item.name }}</strong> <span class="d-inline-block">x{{ item.quantity }} </span>
                                        <span class="d-block">{{ item.unit_price | money }}</span>
                                    </p>
                                </div> 
                            </div>  
                        </div>
                    {% endfor %}
                {% endblock %}
                {% block card_foot %}
                    <div class="row justify-content-center">
                        <div class="col-12">
                            {% if order.shipping or order.discount %}
                                <div class="row font-medium my-2">
                                    <strong class="col mr-1">{{ 'Subtotal' | translate }}:</strong> 
                                    <strong class="col-auto text-right">{{ order.subtotal | money }}</strong>
                                </div>
                            {% endif %}
                            {% if order.show_shipping_price %}
                                <div class="row  mt-2">
                                    <span class="col col-md-auto mr-1">
                                        {{ 'Costo de envío ({1})' | translate(order.shipping_name) }}:
                                    </span>
                                    <span class="col text-right">
                                        {% if order.shipping == 0  %}
                                            {{ 'Gratis' | translate }}
                                        {% else %}
                                            {{ order.shipping | money }}
                                        {% endif %}
                                    </span>
                                </div>
                            {% else %}
                                <div class="row">
                                    <span class="col mr-1">{{ 'Costo de envío ({1})' | translate(order.shipping_name) }}:</span>
                                    <span class="col-auto text-right">{{ 'A convenir' | translate }}</span>
                                </div>
                            {% endif %}
                            {% if order.discount %}
                                <div class="row mt-2">
                                    <span class="col mr-1">{{ 'Descuento ({1})' | translate(order.coupon) }}:</span>
                                    <span class="col-auto text-right">- {{ order.discount | money }}</span>
                                </div>
                            {% endif %}
                            <div class="row font-medium mt-3">
                                <strong class="col mr-1">{{ 'Total' | translate }}:</strong>
                                <strong class="col-auto text-right">{{ order.total | money }}</strong>
                            </div>
                            {% if order.pending %}
                                <a class="btn btn-primary d-block mt-3" href="{{ order.checkout_url | add_param('ref', 'orders_details') }}" target="_blank">{{ 'Realizar pago' | translate }}</a>
                            {% endif %}
                        </div>
                    </div>
                {% endblock %}
            </div>
        </div>
    </div>
</section>