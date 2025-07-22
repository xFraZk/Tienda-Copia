{% if product_detail %}
	
	{# Wording to notice that adding one more product free shipping is achieved #}

	{% if not product.free_shipping %}
		<span class="js-shipping-add-product-label mb-3 w-100" style="display: none;">
			<span class='js-fs-add-this-product'>{{ "¡Agregá este producto y " | translate }}</span>
			<span class='js-fs-add-one-more' style='display: none;'>{{ "¡Agregá uno más y " | translate }}</span>
			<strong class="text-accent">{{ "tenés envío gratis!" | translate }}</strong>
		</span>
	{% endif %}
{% else %}

	<div class="js-fulfillment-info js-visible-on-cart-filled js-allows-non-shippable pb-1" {% if not cart.has_shippable_products %}style="display: none"{% endif %}>

		{# Free shipping progress bar #}
		<div class="js-ship-free-rest">
			<div class="js-bar-progress bar-progress">
				<div class="js-bar-progress-active bar-progress-active transition-soft">
					<div class="js-bar-progress-check bar-progress-icon transition-soft">
						{% include "snipplets/svg/truck.tpl" with {svg_custom_class: "icon-inline icon-xs"} %}
					</div>
				</div>
			</div>
			<div class="js-ship-free-rest-message ship-free-rest-message">
				<div class="ship-free-rest-text bar-progress-success h5 transition-soft">
					{{ "¡Genial! Tenés envío gratis" | translate }}
				</div>
				<div class="ship-free-rest-text bar-progress-amount h6 transition-soft">
					{{ "¡Estás a <strong class='js-ship-free-dif font-medium'></strong> de tener <strong>envío gratis</strong>!" | translate }}
				</div>
				<div class="ship-free-rest-text bar-progress-condition h6 transition-soft">
					{{ "<strong>Envío gratis</strong> superando los" | translate }} <span>{{ cart.free_shipping.min_price_free_shipping.min_price }}</span>
				</div>
			</div>
		</div>
	</div>
{% endif %}