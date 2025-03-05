import { Controller } from "@hotwired/stimulus";
import { loadConnectAndInitialize } from '@stripe/connect-js';
import { post } from "@rails/request.js";

// Connects to data-controller="stripe-onboarding"
export default class extends Controller {
  connect() {
    const fetchClientSecret = async () => {
      // Fetch the AccountSession client secret
      const response = await post('/account_session');
      if (!response.ok) {
        // Handle errors on the client side here
        const {error} = await response.json();
        console.error('An error occurred: ', error);
        document.querySelector('#error').removeAttribute('hidden');
        return undefined;
      } else {
        const {client_secret: clientSecret} = await response.json();
        document.querySelector('#error').setAttribute('hidden', '');
        return clientSecret;
      }
    };
    
    const accountOnboarding = stripeConnectInstance.create('account-onboarding');
    accountOnboarding.setOnExit(() => {
      console.log('User exited the onboarding flow');
    });
    container.appendChild(accountOnboarding);
  }
}
