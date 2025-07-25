<section class="js-advertising-bar section-advertising">
    <div class="container-fluid">
        <div class="row">
            <div class="col text-md-center">
                {% if settings.ad_bar and settings.ad_text %}
                    {% if settings.ad_url %}
                        <a class="link-contrast" href="{{ settings.ad_url | setting_url }}">
                    {% endif %}  
                    {% if settings.ad_text %}
                        {{ settings.ad_text }}
                    {% endif %}
                    {% if settings.ad_url %}
                        </a>
                    {% endif %}
                {% endif %}
            </div>
        </div>
    </div>
</section>
