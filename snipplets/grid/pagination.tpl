{% if infinite_scroll %}
    {% if pages.current == 1 and not pages.is_last %}
        <div class="text-center mt-5 mb-5">
            <a class="js-load-more btn btn-primary">
                <span class="js-load-more-spinner" style="display:none;">{% include "snipplets/svg/spinner-third.tpl" with {svg_custom_class: "icon-inline icon-spin"} %}</span>
                {{ 'Mostrar más productos' | t }}
            </a>
        </div>
        <div id="js-infinite-scroll-spinner" class="mt-5 mb-5 text-center w-100" style="display:none">
            <i class="spinner col-4 offset-4"></i>
        </div>
    {% endif %}
{% else %}
    {% if pages.numbers %}
        <div class="d-flex justify-content-center align-items-center">
            <a {% if pages.previous %}href="{{ pages.previous }}"{% endif %} class="mr-3 {% if not pages.previous %}opacity-30 disabled{% endif %}">
                {% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline svg-icon-text mr-2 icon-2x"} %}
            </a>
            <div class="h4 mb-0 text-center font-weight-normal">
                <span>{{ pages.current }}</span>
                <span>{{'de' | translate }}</span>
                <span>{{ pages.amount }}</span>
            </div>
            <a {% if pages.next %}href="{{ pages.next }}"{% endif %} class="ml-3 {% if not pages.next %}opacity-30 disabled{% endif %}">
                {% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline svg-icon-text ml-2 icon-2x"} %}
            </a>
        </div>
    {% endif %}
{% endif %}
