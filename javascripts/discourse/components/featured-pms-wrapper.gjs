import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { inject as service } from '@ember/service';
import { defaultHomepage } from 'discourse/lib/utilities';
import { TopicList } from "discourse/components/topic-list";
import FeaturedPms from '../components/featured-pms';

export default class FeaturedPmsWrapper extends Component {
  @service router;
  @service currentUser;
  @service siteSettings;
  @tracked FeaturedPms = JSON.parse(settings.featured_lists);

  <template>
    {{#if this.showOnRoute}}
      <div class='featured-pms__wrapper {{settings.plugin_outlet}}'>
        {{#each this.FeaturedPms as |list|}}
          <FeaturedPms @list={{list}} />
        {{/each}}
      </div>
    {{/if}}
  </template>

  get showOnRoute() {
    // TODO: add setting to show for non-admins
    if (!this.currentUser.admin) {
      return false
    }
    const currentRoute = this.router.currentRouteName;
    switch (settings.show_on) {
      case 'everywhere':
        return !currentRoute.includes('admin');
      case 'homepage':
        return currentRoute === `discovery.${defaultHomepage()}`;
      case 'custom':
        return currentRoute === `discovery.custom`;
      case 'latest/top/new/categories':
        const topMenu = this.siteSettings.top_menu;
        const targets = topMenu.split('|').map((opt) => `discovery.${opt}`);
        return targets.includes(currentRoute);
      case 'latest':
        return currentRoute === `discovery.latest`;
      case 'categories':
        return currentRoute === `discovery.categories`;
      case 'top':
        return currentRoute === `discovery.top`;
      default:
        return false;
    }
  }
}
