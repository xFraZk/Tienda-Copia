{% if settings.show_instafeed and store.instagram %}
    <section class="section-instafeed-home px-2 px-md-3" data-store="home-instagram-feed">
        <div class="container-fluid">
            <div class="row justify-content-center">
                {% set instuser = store.instagram|split('/')|last %}
                <div class="col-12 col-md-5">
                    <div class="instafeed-card">
                        <a target="_blank" href="{{ store.instagram }}" class="instafeed-title" aria-label="{{ 'Instagram de' | translate }} {{ store.name }}">
                            <h2 class="h2 h1-md mt-2 mb-4">{{ 'Seguinos en Instagram' | translate }}</h2>
                            <div class="instafeed-user mb-4">@{{ instuser }}</div>
                        </a>
                    </div>
                </div>
                <div class="col-10 col-md-7">
                    <div class="js-ig-fallback instafeed-card instafeed-card-full text-center">
                        <div class="instafeed-profile">
                            <a target="_blank" href="{{ store.instagram }}" class="link-contrast" aria-label="{{ 'Instagram de' | translate }} {{ store.name }}">
                                {% include "snipplets/svg/instagram.tpl" with {svg_custom_class: "icon-inline icon-3x align-top svg-icon-invert"} %}
                                <div class="mt-2">{{ 'Ver perfil' | translate }}</div>
                            </a>
                        </div>
                    </div>
                    {% if store.hasInstagramToken() %}
                        <div id="instagram-feed" class="js-ig-success instagram-feed mt-md-0 row" 
                            data-ig-feed
                            data-ig-items-count="6"
                            data-ig-item-class="col-md-4 col-6 mb-4"
                            data-ig-link-class="instafeed-link"
                            data-ig-image-class="instafeed-img w-100 fade-in"
                            data-ig-aria-label="{{ 'Publicación de Instagram de' | translate }} {{ store.name }}"
                            style="display: none;">  
                        </div>
                    {% endif %}
                </div>
            </div>
        </div>
    </section>
{% endif %}
