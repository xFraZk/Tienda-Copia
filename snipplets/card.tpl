{# /*============================================================================
  #Card
==============================================================================*/

#Head
    // Block - card_head
#Body
    // Block - card_body
#Footer
    // Block - card_footer

#}

<div class="{% if card_collapse %}js-card-collapse {% endif %} card {{ card_custom_class }} {% if card_active %}active{% endif %}">
    <div class="card-body">
        {% block card_body %}{% endblock %}
    </div>
    <div class="{% if card_collapse %}card-header-collapse {% endif %}card-header p-0">
        {% block card_head %}{% endblock %}
        {% if card_collapse %}
            <span class="js-card-collapse-toggle card-collapse-toggle {% if card_active %}active{% endif %}">
                {% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline svg-icon-text mr-4 mt-1 icon-2x"} %}
            </span>
        {% endif %}
    </div>  
    {% if card_footer %}
        <div class="card-footer">
            {% block card_foot %}{% endblock %}
        </div>
    {% endif %}
</div>