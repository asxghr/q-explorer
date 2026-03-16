CREATE TABLE "historical_contexts" (
	"id" serial PRIMARY KEY NOT NULL,
	"topic_id" integer NOT NULL,
	"title" text NOT NULL,
	"content" text NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE "prophet_details" (
	"id" serial PRIMARY KEY NOT NULL,
	"prophet_id" integer NOT NULL,
	"section_title" text NOT NULL,
	"content" text NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE "prophets" (
	"id" serial PRIMARY KEY NOT NULL,
	"name_arabic" text NOT NULL,
	"name_english" text NOT NULL,
	"slug" text NOT NULL,
	"brief_description" text,
	"mention_count" integer DEFAULT 0,
	CONSTRAINT "prophets_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "surahs" (
	"id" serial PRIMARY KEY NOT NULL,
	"number" integer NOT NULL,
	"name_arabic" text NOT NULL,
	"name_english" text NOT NULL,
	"name_transliteration" text NOT NULL,
	"revelation_type" text NOT NULL,
	"verse_count" integer NOT NULL,
	"revelation_order" integer,
	CONSTRAINT "surahs_number_unique" UNIQUE("number")
);
--> statement-breakpoint
CREATE TABLE "tafsirs" (
	"id" serial PRIMARY KEY NOT NULL,
	"verse_id" integer NOT NULL,
	"source_name" text NOT NULL,
	"content" text NOT NULL,
	"language" text DEFAULT 'en' NOT NULL
);
--> statement-breakpoint
CREATE TABLE "topics" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"slug" text NOT NULL,
	"description" text,
	CONSTRAINT "topics_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "verse_prophets" (
	"verse_id" integer NOT NULL,
	"prophet_id" integer NOT NULL,
	CONSTRAINT "verse_prophets_verse_id_prophet_id_pk" PRIMARY KEY("verse_id","prophet_id")
);
--> statement-breakpoint
CREATE TABLE "verse_topics" (
	"verse_id" integer NOT NULL,
	"topic_id" integer NOT NULL,
	CONSTRAINT "verse_topics_verse_id_topic_id_pk" PRIMARY KEY("verse_id","topic_id")
);
--> statement-breakpoint
CREATE TABLE "verses" (
	"id" serial PRIMARY KEY NOT NULL,
	"surah_id" integer NOT NULL,
	"verse_number" integer NOT NULL,
	"arabic_text" text NOT NULL,
	"english_translation" text NOT NULL,
	"transliteration" text,
	"juz_number" integer,
	"hizb_number" integer,
	"page_number" integer
);
--> statement-breakpoint
ALTER TABLE "historical_contexts" ADD CONSTRAINT "historical_contexts_topic_id_topics_id_fk" FOREIGN KEY ("topic_id") REFERENCES "public"."topics"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "prophet_details" ADD CONSTRAINT "prophet_details_prophet_id_prophets_id_fk" FOREIGN KEY ("prophet_id") REFERENCES "public"."prophets"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tafsirs" ADD CONSTRAINT "tafsirs_verse_id_verses_id_fk" FOREIGN KEY ("verse_id") REFERENCES "public"."verses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "verse_prophets" ADD CONSTRAINT "verse_prophets_verse_id_verses_id_fk" FOREIGN KEY ("verse_id") REFERENCES "public"."verses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "verse_prophets" ADD CONSTRAINT "verse_prophets_prophet_id_prophets_id_fk" FOREIGN KEY ("prophet_id") REFERENCES "public"."prophets"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "verse_topics" ADD CONSTRAINT "verse_topics_verse_id_verses_id_fk" FOREIGN KEY ("verse_id") REFERENCES "public"."verses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "verse_topics" ADD CONSTRAINT "verse_topics_topic_id_topics_id_fk" FOREIGN KEY ("topic_id") REFERENCES "public"."topics"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "verses" ADD CONSTRAINT "verses_surah_id_surahs_id_fk" FOREIGN KEY ("surah_id") REFERENCES "public"."surahs"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
CREATE UNIQUE INDEX "surahs_number_idx" ON "surahs" USING btree ("number");--> statement-breakpoint
CREATE INDEX "tafsirs_verse_source_idx" ON "tafsirs" USING btree ("verse_id","source_name");--> statement-breakpoint
CREATE UNIQUE INDEX "verses_surah_verse_idx" ON "verses" USING btree ("surah_id","verse_number");--> statement-breakpoint
CREATE INDEX "verses_surah_id_idx" ON "verses" USING btree ("surah_id");--> statement-breakpoint
CREATE INDEX "verses_juz_idx" ON "verses" USING btree ("juz_number");