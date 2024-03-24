import { CollectionConfig } from "payload/types";

export const Photos: CollectionConfig = {
  slug: "photos",
  fields: [
    {
      name: "title",
      type: "text",
      required: false,
    },
  ],
  access: {
    read: () => true,
  },
};
