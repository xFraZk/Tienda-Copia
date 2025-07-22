{% if product_detail %}
	{% set cart_zipcode = false %}
{% else %}
	{% set cart_zipcode = cart.shipping_zipcode %}
{% endif %}

<div class="{% if product_detail %}product-shipping-calculator{% endif %} mb-2 w-100" data-store="shipping-calculator">
	<div class="js-shipping-calculator-head shipping-calculator-head position-relative transition-soft {% if cart_zipcode %}with-zip{% else %}with-form{% endif %}">
		<div class="js-shipping-calculator-with-zipcode {% if cart_zipcode %}js-cart-saved-zipcode transition-up-active{% endif %} mb-4 w-100 transition-up position-absolute">
			<div class="container p-0">
				<div class="row align-items-center">
					<span class="col pr-0">
						<span class="text-uppercase font-small align-sub">
							<span>{{ "Entregas para el CP:" | translate }}</span>
							<strong class="js-shipping-calculator-current-zip">{{ cart_zipcode }}</strong>
						</span>
					</span>
					<div class="col-auto pl-0">
						<a class="js-shipping-calculator-change-zipcode btn btn-default btn-small float-right" href="#">{{ "Cambiar CP" | translate }}</a>
					</div>
				</div>
			</div>
		</div>
		<div class="js-shipping-calculator-form shipping-calculator-form transition-up position-absolute">

			{# Shipping calcualtor input #}
			
			{% embed "snipplets/forms/form-input.tpl" with{
				type_tel: true, 
				input_value: cart_zipcode, 
				input_name: 'zipcode', 
				input_custom_class: 'js-shipping-input', 
				input_label_custom_class: "pl-1", 
				input_custom_label_text: true, 
				input_placeholder: "Tu código postal" | translate, 
				input_label: false, input_append_content: true, 
				form_control_container_custom_class: 'col-7 col-lg-8 pr-0', 
				input_group_custom_class: 'form-row form-group-inline align-items-center mb-3',
				input_aria_label: 'Tu código postal' | translate } %}
				{% block input_prepend_content %}
					<div class="col-12 mb-2 pb-1">
						<div class="h4 mb-0">							
							{{ 'Medios de envío' | translate }}
						</div>
					</div>
				{% endblock input_prepend_content %}
				{% block input_form_alert %}
					{% set zipcode_help_countries = ['BR', 'AR', 'MX'] %}
					{% if store.country in zipcode_help_countries %}
						{% set zipcode_help_ar = 'https://www.correoargentino.com.ar/formularios/cpa' %}
						{% set zipcode_help_br = 'http://www.buscacep.correios.com.br/sistemas/buscacep/' %}
						{% set zipcode_help_mx = 'https://www.correosdemexico.gob.mx/SSLServicios/ConsultaCP/Descarga.aspx' %}
						<div class="col-12">
							<a class="font-small mt-3 mb-2 ml-2 d-block" href="{% if store.country == 'AR' %}{{ zipcode_help_ar }}{% elseif store.country == 'BR' %}{{ zipcode_help_br }}{% elseif store.country == 'MX' %}{{ zipcode_help_mx }}{% endif %}" target="_blank">{{ "No sé mi código postal" | translate }}</a>
						</div>
					{% endif %}
					<div class="col-12">
						<div class="js-ship-calculator-error invalid-zipcode alert alert-danger" style="display: none;">
							{# Specific error message considering if store has multiple languages #}

							{% for language in languages %}
								{% if language.active %}
									{% if languages | length > 1 %}
										{% set wrong_zipcode_wording = ' para ' | translate ~ language.country_name ~ '. Podés intentar con otro o' | translate %}
									{% else %}
										{% set wrong_zipcode_wording = '. ¿Está bien escrito?' | translate %}
									{% endif %}
									{{ "No encontramos este código postal{1}" | translate(wrong_zipcode_wording) }}

									{% if languages | length > 1 %}
										<a href="#" data-toggle="#{% if product_detail %}product{% else %}cart{% endif %}-shipping-country" class="js-modal-open btn-link btn-link-primary text-lowercase">
											{{ 'cambiar tu país de entrega' | translate }}
										</a>
									{% endif %}
								{% endif %}
							{% endfor %}
						</div>
						<div class="js-ship-calculator-error js-ship-calculator-common-error alert alert-danger" style="display: none;">{{ "Ocurrió un error al calcular el envío. Por favor intentá de nuevo en unos segundos." | translate }}</div>
						<div class="js-ship-calculator-error js-ship-calculator-external-error alert alert-danger" style="display: none;">{{ "El calculo falló por un problema con el medio de envío. Por favor intentá de nuevo en unos segundos." | translate }}</div>
					</div>
				{% endblock input_form_alert %}
				{% block input_append_content %}
					<div class="col-5 col-lg-4 pl-0">
						<button class="js-calculate-shipping btn btn-default btn-block" aria-label="{{ 'Calcular envío' | translate }}">	
							<span class="js-calculate-shipping-wording">{{ "Calcular" | translate }}</span>
							<span class="js-calculating-shipping-wording" style="display: none;">{{ "Calculando" | translate }}</span>
						</button>
						{% if shipping_calculator_variant %}
							<input type="hidden" name="variant_id" id="shipping-variant-id" value="{{ shipping_calculator_variant.id }}">
						{% endif %}
					</div>
				{% endblock input_append_content %}
			{% endembed %}
		</div>
	</div>
	<div class="js-shipping-calculator-spinner shipping-spinner-container mt-2 mb-5 transition-soft" style="display: none;">
		<i class="spinner col-6 offset-3"></i>
	</div>
	<div class="js-shipping-calculator-response mb-3 float-left w-100 {% if product_detail %}list list-readonly{% endif %}" style="display: none;"></div>
</div>

{# Shipping country modal #}

{% if languages | length > 1 %}

	{% if product_detail %}
		{% set country_modal_id = 'product-shipping-country' %}
	{% else %}
		{% set country_modal_id = 'cart-shipping-country' %}
	{% endif %}

	{% embed "snipplets/modal.tpl" with{modal_id: country_modal_id, modal_class: 'bottom modal-centered-small js-modal-shipping-country', modal_position: 'center', modal_transition: 'slide', modal_header: true, modal_footer: true, modal_footer_class: 'pt-0', modal_width: 'centered', modal_zindex_top: true, modal_mobile_full_screen: false} %}
		{% block modal_head %}
		    {{ 'País de entrega' | translate }}
		{% endblock %}
		{% block modal_body %}
		    {% embed "snipplets/forms/form-select.tpl" with{select_label: true, select_label_name: 'País donde entregaremos tu compra' | translate, select_aria_label: 'País donde entregaremos tu compra' | translate, select_custom_class: 'js-shipping-country-select', select_group_custom_class: 'mt-4' } %}
				{% block select_options %}
					{% for language in languages %}
						<option value="{{ language.country }}" data-country-url="{{ language.url }}" {% if language.active %}selected{% endif %}>{{ language.country_name }}</option>
					{% endfor %}
				{% endblock select_options%}
			{% endembed %}
		{% endblock %}
		{% block modal_foot %}
			<a href="#" class="js-save-shipping-country btn btn-primary float-right">{{ 'Aplicar' | translate }}</a>
		{% endblock %}
	{% endembed %}
{% endif %}