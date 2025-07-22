{% if store.allows_checkout_styling %}

/*============================================================================
checkout.scss.tpl

    -This file contains all the theme styles related to the checkout based on settings defined by user from config/settings.txt
    -Rest of styling can be found in:
        -static/css/style-colors.scss.tpl --> For color and font styles related to config/settings.txt
        -static/css/style-async.scss.tpl --> For non critical styles witch will be loaded asynchronously
        -static/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

==============================================================================*/

{#/*============================================================================
  Global
==============================================================================*/#}

{# /* // Colors */ #}

$accent-brand-color: {{ settings.primary_color | default('rgb(77, 190, 207)' | raw ) }};
$foreground-color: {{ settings.positive_color | default('rgb(102, 102, 102)' | raw ) }};
$background-color: {{ settings.negative_color | default('rgb(252, 252, 252)' | raw ) }};

{# /* // Font */ #}

$heading-font: {{ settings.font_headings | default('Fraunces') | raw }};
$body-font: {{ settings.font_rest | default('IBM Plex Sans') | raw }};

{# /* // Box */ #}
$box-border-color: null;
@if lightness($background-color) > 95% {
  $box-border-color: desaturate(darken($background-color, 15%), 10%);
} @else {
  $box-border-color: desaturate(darken($background-color, 8%), 10%);
}
$box-radius: 10px;
$box-background: lighten($background-color, 10%);
$box-shadow: null;
@if lightness($background-color) > 50% {
  $box-shadow: 0px 1px 5px -1px rgba(0, 0, 0, 0.2);
} @else {
  $box-shadow: 0px 1px 5px -1px rgba(0, 0, 0, 0.3);
}

{# /* // Functions */ #}

@function set-background-color($background-color) {
  @if lightness($background-color) > 95% {
    @return lighten($background-color, 10%);
  } @else {
    @return desaturate(lighten($background-color, 7%), 5%);
  }
}

@function set-input-color($background-color, $foreground-color) {
  @if lightness($background-color) > 70% {
    @return desaturate(lighten($foreground-color, 5%), 80%);
  } @else {
    @return desaturate(lighten($background-color, 5%), 80%);
  }
}

{#/*============================================================================
  React
==============================================================================*/#}

{# /* // Box */ #}

$box-background: lighten($background-color, 10%);
$box-text-shadow: null;
@if lightness($foreground-color) > 95% {
  $box-text-shadow: 0 2px 1px rgba(darken($foreground-color, 80%), 0.1);
} @else {
  $box-text-shadow: 0 2px 1px rgba(lighten($foreground-color, 80%), 0.1);
}

$base-red: #c13a3a;

$xs: 0;
$md: 768px;
$xl: 1200px;

{#/*============================================================================
  # Checkout tokens
==============================================================================*/#}
:root {
  {#### Color tokens #}

  {% set accent_color = settings.primary_color %}
  {% set main_foreground = settings.positive_color %}
  {% set main_background = settings.negative_color %}

  {# Auxiliar opacity hex levels #}
  {% set opacity_05 = '0D' %}
  {% set opacity_10 = '1A' %}
  {% set opacity_20 = '33' %}
  {% set opacity_30 = '4D' %}
  {% set opacity_50 = '80' %}
  {% set opacity_60 = '99' %}
  {% set opacity_80 = 'CC' %}

  {# Accent color #}
  --accent-color: {{ accent_color }};
  --accent-color-opacity-05: {{ accent_color }}{{ opacity_05 }};
  --accent-color-opacity-10: {{ accent_color }}{{ opacity_10 }};
  --accent-color-opacity-20: {{ accent_color }}{{ opacity_20 }};
  --accent-color-opacity-30: {{ accent_color }}{{ opacity_30 }};
  --accent-color-opacity-50: {{ accent_color }}{{ opacity_50 }};
  --accent-color-opacity-60: {{ accent_color }}{{ opacity_60 }};
  --accent-color-opacity-80: {{ accent_color }}{{ opacity_80 }};

  {# Foreground color #}
  --main-foreground: {{ main_foreground }};
  --main-foreground-opacity-05: {{ main_foreground }}{{ opacity_05 }};
  --main-foreground-opacity-10: {{ main_foreground }}{{ opacity_10 }};
  --main-foreground-opacity-20: {{ main_foreground }}{{ opacity_20 }};
  --main-foreground-opacity-30: {{ main_foreground }}{{ opacity_30 }};
  --main-foreground-opacity-50: {{ main_foreground }}{{ opacity_50 }};
  --main-foreground-opacity-60: {{ main_foreground }}{{ opacity_60 }};
  --main-foreground-opacity-80: {{ main_foreground }}{{ opacity_80 }};

  {# Background color #}
  --main-background: {{ main_background }};
  --main-background-opacity-05: {{ main_background }}{{ opacity_05 }};
  --main-background-opacity-10: {{ main_background }}{{ opacity_10 }};
  --main-background-opacity-20: {{ main_background }}{{ opacity_20 }};
  --main-background-opacity-30: {{ main_background }}{{ opacity_30 }};
  --main-background-opacity-50: {{ main_background }}{{ opacity_50 }};
  --main-background-opacity-60: {{ main_background }}{{ opacity_60 }};
  --main-background-opacity-80: {{ main_background }}{{ opacity_80 }};

  {#### Component tokens #}

  {# General #}
  --border-radius: 10px;
  --box-border-radius: var(--border-radius);
  --border-color: #{$box-border-color}; {# Relies on Sass darken/lighten functions #}
  --box-border-color: var(--main-foreground-opacity-10);
  --input-border-color: var(--border-color);

  {# Buttons #}
  --button-foreground: var(--main-background);
  --button-background: var(--accent-color);
  --button-border-color: var(--accent-color);
  --button-border-radius: var(--border-radius);

  {# Labels #}
  --label-foreground: var(--main-background);
  --label-background: var(--accent-color);

  {# Header #}
  --header-foreground: var(--main-background);
  --header-background: var(--main-foreground);
  --header-logo-max-width: 100%;
  --header-logo-max-height: 80px;

  {# Footer #}
  --footer-foreground: var(--main-foreground);
  --footer-background: var(--main-background);

  {#### Typography #}

  {# Headings #}
  --heading-font: {{ settings.font_headings | default('Fraunces') | raw }};
  --heading-font-weight: 700;
  --heading-text-transform: none;
  --heading-letter-spacing: normal;

  {# Header #}
  --header-logo-font: {{ settings.font_headings | default('Fraunces') | raw }};
  --header-logo-font-size: 24px;
  --header-logo-font-weight: 700;
  --header-logo-text-transform: none;
  --header-logo-letter-spacing: 1px;
}

body {
  font-family: $body-font;
  color: $foreground-color;
  background-color: $background-color;
}
a {
  color: $accent-brand-color;
  text-decoration: none;
  &:hover,
  &:focus {
    color: darken($accent-brand-color, 20%);
    
    svg {
      fill: darken($accent-brand-color, 20%);
    }
  }
  
  svg {
    fill: $accent-brand-color;
  }
}

{# /* // Text */ #}

.title {
  color: $foreground-color;
}

{# /* // Header */ #}

.header { 
  background-color: lighten($background-color, 10%);
  border-color: $accent-brand-color;
}

.security-seal {
  color: $background-color;
}

{# /* // Container */ #}

.container {
  max-width: 100%;
  width: 100%;
}

{# /* // Headbar */ #}

.headbar {
  background: $foreground-color;
  box-shadow: none;

  .row {
    -ms-flex-align: center;
    align-items: center;
    
    .col {
      text-align: left !important;
      flex-basis: auto;
      &.text-left {
        padding: 20px;
      }
    }
  }
}

.headbar-logo-img {
  max-width: 100%;
  max-height: 80px;
}

.headbar-logo-text {
  float: none;
  font-family: $heading-font;
  font-size: 24px;
  font-weight: 700;
  color: $background-color;
  letter-spacing: 1px;

  &:hover,
  &:focus {
    color: $background-color;
    opacity: .8;
  }
}

.headbar-continue {
  margin: 0 !important;
  padding: 10px 0;
  font-size: 12px;
  font-weight: 400;
  color: $background-color;
  text-transform: uppercase;

  &:hover,
  &:focus {
    color: $background-color;
    opacity: .8;

    .headbar-continue-icon {
      fill: $background-color;
    }
  }
  &-icon {
    margin-left: 5px;
    fill: $background-color;
  }
}

{# /* // Form */ #}

.form-control {
  border-color: $box-border-color;
  font-family: $body-font;
  background: $background-color;
  color: $foreground-color;
  border-radius: $box-radius;

  &:focus {
    border-color: $foreground-color;
    outline: none;    
  }
}
.form-options-content {
  font-size: 12px;
  line-height: 20px;
  color: rgba($foreground-color, .6);
  border: 0;
}
.form-group-error .form-control {
  border-color: $base-red;

  &:focus {
    border-color: $base-red;
  }
}
.form-group input[type="radio"] + .form-options-content {
  .unchecked {
    fill: darken($background-color, 10%);
  }
  .checked {
    fill: $accent-brand-color;
  }
}
.form-group input[type="radio"]:checked + .form-options-content {
  border: 1px solid $accent-brand-color;
  border-color: darken($background-color, 10%);
  
  + .form-options-accordion {
    border-color: darken($background-color, 10%);
  }
  
  .checked {
    fill: $accent-brand-color;
  }
}
.form-group input[type="checkbox"]:checked + .form-options-content .checked {
  fill: $foreground-color;
}
.form-group input[disabled] + .form-options-content {
  border-color: darken($background-color, 10%) !important;
  
  .form-options-label {
    color: $foreground-color !important;
  }
  .checked {
    fill: $foreground-color !important;
  }
}
.form-group input[type="checkbox"] + .form-options-content .unchecked {
  width: 13px;
  fill: $foreground-color;
}

{# /* // Input */ #}

.has-float-label>span,
.has-float-label label {
  padding: 1px 0 0 7px;
  font-weight: 400;
}

.input-label {
  color: $foreground-color;
}

.select-icon {
  fill: $foreground-color;
}

.input-group .has-float-label {
  margin-right: 1em;
}

{# /* // Buttons */ #}

.btn-primary {
  color: $background-color;
  font-family: $body-font;
  font-size: 14px;
  background: $accent-brand-color;
  border-radius: $box-radius;
  letter-spacing: 4px;
  {% if settings.primary_color_gradient %}
    background:linear-gradient(to right, adjust-hue($accent-brand-color, -30%), $accent-brand-color);
    background-size: 100%;
    transition: background 1s ease;
  {% endif %}

  &:hover,
  &:focus,
  &:active {
    color: $background-color;
    {% if settings.primary_color_gradient %}
      background:linear-gradient(to right, adjust-hue($accent-brand-color, -30%), $accent-brand-color);
      background-size: 200%;
    {% else %}
      background: $accent-brand-color;
    {% endif %}
    opacity: 1;
  }

}
.btn-secondary,
.box-discount-coupon-applied {
  position: sticky;
  font-size: 12px;
  text-transform: uppercase;
  letter-spacing: 2px;
  background: $background-color;
  border-radius: $box-radius;
  transition: .5s;

  {% if settings.primary_color_gradient %}
    color: $foreground-color;
    border: 0;

    &:after,
    &:before {
      position: absolute;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;
      margin: auto;
      border-radius: $box-radius;
      content: '';
    }
    &:before {
      z-index: -1;
      width: calc(100% - 2px);
      height: calc(100% - 2px);
      background: $background-color;
    }
    &:after{
      z-index: -2;
      width: 100%;
      height: 100%;
      background: linear-gradient(to right, adjust-hue($accent-brand-color, -30%), $accent-brand-color);
    }
  {% else %}
    color: $accent-brand-color;
    border: 1px solid $accent-brand-color;
  {% endif %}

  &:hover,
  &:focus,
  &:active,
  &:active:focus {
    {% if settings.primary_color_gradient %}
      color: $accent-brand-color;
    {% else %}
      background: $accent-brand-color;
      color: $background-color;
    {% endif %}

    .btn-icon-right {
      fill: $background-color;
    }
  }
  .btn-icon-right {
    fill: $accent-brand-color;
    transition: .5s;
  }
}
.btn-transparent {
  color: $accent-brand-color;

  &:hover {
    color: $accent-brand-color;
    
    .btn-icon-right {
      fill: $accent-brand-color;
    }
  }
  
  .btn-icon-right {
    fill: $accent-brand-color;
  }
}

.btn-link {
  color: $foreground-color;
  text-decoration: none;

  &:hover {
    color: $accent-brand-color;

    svg {
      fill: $accent-brand-color;
    }
  }
}

.btn-picker {
  border-color: $box-border-color;
}

.login-info {
  margin: 10px 0 0;
  font-size: 12px;
  text-align: left;
}

{# /* // Breadcrumb */ #}

.breadcrumb {
  margin-top: 10px;

  li {

    .breadcrumb-step {
      height: 40px;
      margin: 0;
      font-size: 12px;
      color: rgba($foreground-color, .6);
      background: none;

      &.active {
        color: $foreground-color;
        background: none;

        &:before,
        &:after {
          position: relative;
          margin: 0 10px;
          border: 0;
          content: ">";
          opacity: .6;
        }
      }

      &.visited {
        color: rgba($foreground-color, .6);
        background: none;
      }
    }
    &:first-child .breadcrumb-step,
    &:last-child .breadcrumb-step {
      padding: 0;
    }
  }
}

{# /* // Accordion */ #}

.accordion {
  color: $foreground-color;
  background-color: $background-color;
  border-radius: $box-radius;
  border-color: rgba($foreground-color, .1);
}

.accordion-section-header-icon {
  fill: $foreground-color;
}

.accordion-rotate-icon {
  fill: $foreground-color;
}

{# /* // Summary */ #}

.mobile-discount-coupon_btn {
  border-radius: $box-radius;
  border-color: darken($background-color, 10%);
  color: lighten($foreground-color, 20%);
  
  .icon {
    color: lighten($foreground-color, 20%);
  }
}

.summary-details {
  margin: 0;
  background: $background-color;
}
.summary.fixed {
  border-radius: 0 0 $box-radius $box-radius;
  overflow: hidden;
  box-shadow: $box-shadow;
}
.summary-container {
  background: $background-color;
  box-shadow: none;
}
.summary-total {
  float: left;
  padding: 0;
  font-size: 16px;
  color: $foreground-color;
  background: none;
}
.summary-img-thumb {
  left: 0;
  background: none;
  border-radius: $box-radius 0 0 $box-radius;
}
.summary-arrow-rounded {
  position: absolute;
  right: 15px;
  width: auto;
  background: $background-color;
  .summary-arrow-icon {
    width: 12px;
    height: 12px;
    fill: $foreground-color;
  }
}

.summary-title {
  float: right;
  padding-right: 25px;
  color: $foreground-color;
}

{# /* // Radio */ #}

.radio-group.radio-group-accordion {
  border: 0;

  .radio {
    margin-bottom: 20px;
    border: 1px solid $box-border-color;
    border-radius: $box-radius;

    &.active {
      margin: 0;
      padding-bottom: 10px;
      color: $background-color;
      background: $foreground-color;
      border: 1px solid $foreground-color;
      border-radius: $box-radius $box-radius 0 0;
      .label,
      .description {
        color: $background-color;
      }
      & + .radio-content {
        padding-top: 15px;
        border: 1px solid $foreground-color;
        border-top: none;
      }
    }
    &:hover {
      border: 1px solid $foreground-color;
    }
    .label {
      padding: 10px 0;
      font-size: 16px;
      font-weight: 700;
      color: $foreground-color;
    }
    .description {
      width: calc(100% - 35px);
      margin-left: 35px;
      font-weight: 400;
      color: $foreground-color;
    }
  }
}
.radio input:checked + .selector:before {
  background: none;
  border: 6px solid $background-color;
}
.radio input:disabled:checked + .selector:before {
  background-image: radial-gradient(circle, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0.5) 50%, transparent 50%, transparent 100%);
}
.radio .selector:before {
  width: 20px;
  height: 20px;
  margin: 2px 15px 0 0;
  border: 3px solid $foreground-color;
}
.radio-content {
  margin-bottom: 20px;
  background: $background-color;
  border: 0;
  border-radius: 0 0 $box-radius $box-radius;
  box-shadow: none;
}
.shipping-option {
  margin-bottom: 20px;
  border-radius: $box-radius;
  border-color: $box-border-color;

  &:hover {
    border-color: $foreground-color;
  }
  &.active {
    position: relative;
    z-index: 1;
    color: $background-color;
    background: $foreground-color;
    border: 1px solid $foreground-color;
    .shipping-method-item-desc,
    .shipping-method-item-name,
    .shipping-method-item-price {
      color: $background-color;
    }
  }
}

{# /* // Panel */ #}

.panel {
  padding: 0;
  color: lighten($foreground-color, 8%);
  background-color: $background-color;
  border-radius: $box-radius;
  box-shadow: none;
  border: 0;

  &.panel-with-header {
    padding-top: 0;
    p {
      margin: 0 0 25px 0;
    }
  }
}
.panel-header {
  margin: 0;
  font-family: $heading-font;
  font-size: 22px;
  font-weight: 700;
  background: $background-color;
  color: $foreground-color;
  text-align: left;
  border: 0;
  text-shadow: none;
}
.panel-subheader {
  font-size: 12px;
  font-weight: 400;
  text-transform: uppercase;
}
.panel-header-sticky {
  background-color: $background-color;
}
.panel-header-button {
  position: absolute;
  top: 9px;
  right: 0;
  z-index: 2;
  width: auto;
}
.panel-footer {
  border-bottom-right-radius: $box-radius;
  border-bottom-left-radius: $box-radius;
  background: darken($background-color, 2%);
  &-wa {
    border-color: darken($background-color, 5%);
  }
}
.panel-footer-form {
  input {
    border-color: $foreground-color;
  }
  .input-group-addon {
    background: $background-color;
    border-color: $foreground-color;
  }
  .disabled {
    background: darken($background-color, 15%) !important;
  }
}

{# /* // Table */ #}

.table-footer {
  display: block;
  margin-top: 10px;
  font-size: 20px;
  border-top: 0;

  .text-semi-bold {
    font-weight: 400;
  }
}

.table-subtotal {
  margin: 0;
  padding: 15px;
  border: 0;
  font-size: 12px;
  text-transform: uppercase;

  td {
    padding: 5px 0;
  }
  .table tr {
    display: block;
  }
}


.table.table-scrollable {
  padding: 0 15px;
  border-collapse: separate;
  border-spacing: 0 20px;

  tr {
    box-shadow: $box-shadow;
    border-radius: $box-radius;
  }
  td {
    padding: 15px 0 15px 15px;
    &:last-child {
      padding-right: 15px;
    }
  }
  .summary-img-wrap {
    padding: 0;
  }
  .summary-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  .table-price {
    padding-right: 15px;
  }
}
.table .table-discount-coupon,
.table .table-discount-promotion {
  border: 0;
  color: $accent-brand-color;
}

{# /* // Shipping Options */ #}

.shipping-options {
  color: lighten($foreground-color, 7%);

  .btn {
    margin: 0;
  }
}

.shipping-method-item > span {
  width: 100%;
}

.shipping-method-item-desc,
.shipping-method-item-name {
  max-width: 70%;
  color: $foreground-color;
}

.shipping-method-item-price {
  float: right;
  font-size: 16px;
  font-weight: 700;
  color: $foreground-color;
}

.price-striked {
  display: block;
  margin: 5px 0 0 !important;
  font-size: 14px;
  color: rgba($foreground-color, .6);
  text-align: right;
}

{# /* // Discount Coupon */ #}

.box-discount-coupon button {
  color: $foreground-color;
  background: none;

  &:hover {
    background: none;
  }
  svg {
    width: 12px;
    fill: $foreground-color;
  }
}

.box-discount-coupon-applied {
  margin-bottom: 5px;
  color: $foreground-color;
  background: none;
  border-radius: $box-radius;

  .coupon-icon {
    display: none;
  }
}

{# /* // Order Status */ #}

.orderstatus {
  border: 1px solid rgba($foreground-color, .1);
}

.destination {
  border-color: rgba($foreground-color, 0.1);
}

.destination-icon svg {
  fill: $accent-brand-color;
}

{# /* // User Detail */ #}

.user-detail-icon svg {
  fill: $accent-brand-color;
}

{# /* // History */ #}

.history-item-done .history-item-title {
  color: $accent-brand-color;
}
.history-item-failure .history-item-title {
  color: $base-red;
}
.history-item-progress-icon svg {
  @if lightness($background-color) > 50% {
    fill: darken($background-color, 10%);  
  } @else {
    fill: $background-color;
  }
}
.history-item-progress-icon:after {
  @if lightness($background-color) > 50% {
    fill: darken($background-color, 10%);
    border-color: darken($background-color, 10%);
  } @else {
    fill: $background-color;
    border-color: $background-color;
  }
}
.history-item-progress-icon-failure svg {
  fill: $base-red;
}
.history-item-progress-icon-success svg {
  fill: $accent-brand-color;
}
.history-item-progress-icon-success:after {
  border-color: $accent-brand-color;
}

{# /* // History Canceled */ #}

.history-canceled {
  border-top-right-radius: $box-radius;
  border-top-left-radius: $box-radius;

  &-round {
    border-bottom-right-radius: $box-radius;
    border-bottom-left-radius: $box-radius;
  }
  &-header {
    border-color: rgba($box-border-color, 0.7);
    border-top-left-radius: $box-radius;
    border-top-right-radius: $box-radius;
  }
  &-icon svg {
    fill: darken($background-color, 45%);
  }
}

{# /* // Offline Payment */ #}

.ticket-coupon {
  background: darken($background-color, 4%);
  border-color: $box-border-color;
}

{# /* // Status */ #}

.status {
  border: 1px solid rgba($foreground-color, .1);
  padding: 25px 0;
  &-icon svg {
    fill: $accent-brand-color;
  }
}

{# /* // Tracking */ #}

.tracking-item-time {
  color: $foreground-color;
}

{# /* // WhatsApp Opt-in */ #}

.whatsapp-form input, 
.whatsapp-form .input-group-addon {
  border-color: $accent-brand-color;
}

{# /* // Helpers */ #}

.border-top {
  border-color: rgba($box-border-color, .4);
}

{# /* // Errors */ #}

.general-error {
  background: $base-red;
  border-color: lighten($base-red, 10%);
}

{# /* // Badge */ #}

.badge {
  border: 0;
}

{# /* // Payment */ #}

.payment-item-discount {
  display: inline-table;
  margin-top: 3px;
  padding: 5px 10px;
  color: $background-color;
  background: $accent-brand-color;
  font-size: 10px;
  line-height: 12px;
  border-radius: $box-radius;
}

.payment-option {
  border-radius: $box-radius;
  color: $foreground-color;
  background-color: $background-color;
  border-color: $box-border-color;
  &:hover {
    border-color: $foreground-color;
  }
  &.active {
    color: $background-color;
    background-color: $foreground-color;
    border: 1px solid $foreground-color;
    .accordion-section-header-icon {
      fill: $background-color;
    }
  }
}

.radio-content.payment-option-content {
  background: darken($background-color, 2%);
  border: 1px solid $foreground-color;
  border-top: 0;
  border-bottom-right-radius: $box-radius;
  border-bottom-left-radius: $box-radius;
}

{# /* // Overlay */ #}

.overlay {
  background: rgba(darken($background-color, 10%), 0.6);
}
.overlay-title {
  color: rgba($foreground-color, .7);
}

{# /* // List Picker */ #}

.list-picker .unchecked {
  fill: $foreground-color;
}
.list-picker li {
  border-color: $box-border-color;
  background: lighten($background-color, 10%);

  &:hover {
    color: $accent-brand-color;
  }

  &.active {
    background: $background-color;
    color: $accent-brand-color;

    .checked {
      fill: $accent-brand-color;
    }
  }
}
.list-picker-content {
  background: lighten($background-color, 10%);
  border-color: $box-border-color;
}

{# /* // Loading */ #}

.loading {
  background: rgba(darken($background-color, 2%), 0.5);
  color: $accent-brand-color;
}
.loading-spinner {
  color: $accent-brand-color;
}
.loading-skeleton-radio {
  border-color: rgba($box-border-color, 0.5);
  border-radius: $box-radius;
}

{# /* // Spinner */ #}

.round-spinner {
  border-color: $accent-brand-color;
  border-left-color: darken($accent-brand-color, 5%);
  
  &:after {
    border-color: $accent-brand-color;
    border-left-color: darken($accent-brand-color, 5%);
  }
}

.spinner > .spinner-elem {
  background: $accent-brand-color;
}

.spinner-inverted > .spinner-elem {
  background: $background-color;
}

{# /* // Sign Up */ #}

.signup {
  border: 1px solid rgba($foreground-color, .1);
  padding: 25px 0;
}

.signup-icon svg {
  fill: $accent-brand-color;
}

{# /* // Modal */ #}

.modal-dialog,
.modal .modal-dialog {
  background: $background-color;
}

{# /* // List */ #}

.list-group-item {
  border-color: rgba($foreground-color, .1);
}

{# /* // Announcement */ #}

.announcement {
  color: darken($accent-brand-color, 10%);

  &-bg {
    background: $accent-brand-color;
    box-shadow: 0px 3px 5px -1px rgba(darken($accent-brand-color, 20%), 0.35);
    border-radius: $box-radius;
  }

  &-close {
    color: $accent-brand-color;
  }
}

{# /* // Alert */ #}

.alert-info {
  background-color: rgba($accent-brand-color, .15);
  border-color: rgba($accent-brand-color, .2);
  color: desaturate(darken($accent-brand-color, 10%), 30%);

  .alert-icon {
    fill: desaturate(darken($accent-brand-color, 10%), 20%);
  }
}

{# /* // Chip */ #}

.chip {
  background-color: rgba($accent-brand-color, .15);
  color: desaturate(darken($accent-brand-color, 10%), 30%);
  border-radius: 0;
}

{# /* // Tooltip */ #}

.tooltip-icon {
  fill: $foreground-color;
}


{# /* // Review Block Detailed  */ #}

.review-block-detailed-item {
  border-bottom: 1px solid rgba($foreground-color, .1);
}

.review-block-detailed {
  border: 1px solid rgba($foreground-color, .1);
  border-radius: 0;
}

{# /* // Tabs */ #}

.tabs-wrapper {
  background: $background-color;
  border-bottom-color: darken($background-color, 10%);
}

.tab-item.active {
  color: $accent-brand-color;
  font-weight: bold;
}

.tab-indicator {
  background-color: $accent-brand-color;
}

{#/*============================================================================
  #Media queries
==============================================================================*/ #}

{# /* // Min width 1200px */ #}

@media (min-width: $xl) {

  .headbar {
    position: fixed;
    top: 0;
    width: 250px;
    height: 100%;
    padding: 0;

    .row .col.text-right {
      position: absolute;
      bottom: 0;
      width: auto;
      padding: 5px 20px;
      background: rgba($background-color, .2);
      border-radius: 0 $box-radius 0 0;
    }
  }

  .main-container {
    max-width: calc(100% - 250px);
    width: calc(100% - 250px);
    margin-left: 250px;
    padding: 0 30px;
  }

}

{# /* // Max width 1200px */ #}

@media (max-width: $xl) { 

  .headbar .row .col.text-left {
    order: 2;
  }

  .headbar .row .col.text-right {
    margin: -12px 0 15px 0;
    background: #aac67b;
  }

  .security-seal {
    color: #000000;

    .d-inline-block:first-child {
      position: absolute;
      top: 1px;
      left: 126px;
    }
    p {
      display: inline-block;
      &.text-semi-bold {
        margin-right: 50px !important;
      }
    }
    &-badge {
      margin: 0;
    }
  }

}

{# /* // Min width 768px */ #}

@media (min-width: $md) {

  .panel-header {
    font-size: 26px;
  }

  .table.table-scrollable {
    padding: 3px;
  }

  .summary-coupon {
    padding: 0;
  }

  .status,
  .signup {
    padding: 40px 0;
  }

}

{# /* // Max width 0px */ #}

@media (max-width: $xs) {

  .modal-xs {
    background: $background-color;
  }

}

{%  endif %}
