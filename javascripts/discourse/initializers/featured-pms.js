import { apiInitializer } from "discourse/lib/api";
import FeaturedPmsWrapper from "../components/featured-pms-wrapper";

export default apiInitializer("1.14.0", (api) => {
  api.renderInOutlet(settings.plugin_outlet.trim(), FeaturedPmsWrapper);
});
