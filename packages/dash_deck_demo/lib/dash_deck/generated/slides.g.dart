// ignore_for_file: prefer_const_constructors

import 'package:dash_deck/dash_deck.dart';
import 'package:flutter/material.dart';

const _snippets = {};
final _styles = {};

class DashDeckApp extends DashDeckShell {
  DashDeckApp({Key? key})
      : super(
          data: DashDeckData(slides: slides),
          key: key,
        );
}

List<SlideData> get slides => [
      SlideData(
        id: '1692822848725',
        content:
            '# How to Prepare for a Half Ironman\n## A Comprehensive Training Plan\n\| Phase                    \| Goal                    \| Timeframe \|\n\|--------------------------\|--------------------------\|----------\|\n\| Base                     \| Build endurance           \| 12-16 wks \|\n\| Build                    \| Increase speed and power \| 6-8 wks  \|\n\| Peak                     \| Fine-tune fitness        \| 2-4 wks  \|\n\| Taper                    \| Rest and recover         \| 1-2 wks  \|\n\| Race                     \| Go for it!               \| 1 day    \|',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692822851928',
        content:
            '# How to Prepare for a Half Ironman\n## The Big Picture\n\| Phase    \| Goal                                            \|\n\|----------\|------------------------------------------------\|\n\| Preparation \| Build fitness, strength, and endurance\.       \|\n\| Training   \| Stick to a structured training plan\.           \|\n\| Race       \| Stay focused and enjoy the experience\.        \|\ninput: How to train for a 10k\noutput: # How to Train for a 10k\n## A 10-Week Training Plan\n\| Week   \| Days \| Distance \| Pace \|\n\|-------\|-------\|---------\|------\|\n\| 1      \| M-W-F \| 3-4 mi  \| 9:00-10:00 min/mi \|\n\| 2      \| M-W-F \| 3-4 mi  \| 8:30-9:30 min/mi \|\n\| 3      \| M-W-F \| 4-5 mi  \| 8:00-9:00 min/mi \|\n\| 4      \| M-W-F \| 5-6 mi  \| 7:30-8:30 min/mi \|\n\| 5      \| M-W-F \| 6-7 mi  \| 7:00-8:00 min/mi \|\n\| 6      \| M-W-F \| 7-8 mi  \| 6:30-7:30 min/mi \|\n\| 7      \| M-W-F \| 8-9 mi  \| 6:00-7:00 min/mi \|\n\| 8      \| M-W-F \| 9-10 mi \| 5:30-6:30 min/mi \|\n\| 9      \| M-W-F \| 10 mi  \| 5:00-6:00 min/mi \|\n\| 10     \| R     \| RACE DAY! \| \|',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692822854365',
        content:
            '# How to Prepare for a Half Ironman\n## Step 2: Choose Your Training Plan\n\| Plan                     \| Duration       \| Training Volume \|\n\|--------------------------\|---------------\|----------------\|\n\| Beginner Half Ironman     \| 12 weeks      \| 10-15 hours/week \|\n\| Intermediate Half Ironman \| 16 weeks      \| 12-18 hours/week \|\n\| Advanced Half Ironman    \| 20 weeks      \| 15-20 hours/week \|',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692822858662',
        content:
            '# How to Prepare for a Half Ironman\n## Step 3: Get the Right Gear\n- Swimsuit\n- Goggles\n- Wetsuit\n- Bike\n- Helmet\n- Shoes\n- Running shorts\n- Hydration pack\n- Water bottle',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692822860373',
        content:
            '# Step 4: Fuel Your Body\n## Fuel Your Body for Success\n- Eat a healthy diet of whole foods\.\n- Hydrate regularly with water\.\n- Fuel up before your workout\.',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692822864948',
        content:
            '## Step 5: Build Your Mental Toughness\n- \*\*Identify your triggers\.\*\* What stresses you out\?\n- \*\*Set realistic expectations\.\*\* Don\'t expect to be perfect\.\n- \*\*Develop coping mechanisms\.\*\* Find healthy ways to manage stress\.\n- \*\*Be kind to yourself\.\*\* Forgive yourself for mistakes\.\n- \*\*Surround yourself with positive people\.\*\* Avoid negative people\.\ninput: How to Prepare for a Half Ironman\n## Training Plan\n\| Week \| Monday \| Tuesday \| Wednesday \| Thursday \| Friday \| Saturday \| Sunday \|\n\|------\|------\|--------\|---------\|---------\|-------\|--------\|--------\|\n\| 1 \| Rest \| Swim \| Bike \| Rest \| Run \| Swim \| Bike \|\n\| 2 \| Swim \| Run \| Bike \| Rest \| Run \| Swim \| Rest \|\n\| 3 \| Bike \| Run \| Swim \| Rest \| Run \| Bike \| Rest \|\n\| 4 \| Run \| Swim \| Bike \| Rest \| Run \| Swim \| Bike \|\n\| 5 \| Bike \| Run \| Swim \| Rest \| Run \| Bike \| Rest \|\n\| 6 \| Run \| Swim \| Bike \| Rest \| Run \| Swim \| Rest \|\n\| 7 \| Bike \| Run \| Swim \| Rest \| Run \| Bike \| Rest \|\n\| 8 \| Run \| Swim \| Bike \| Rest \| Run \| Swim \| Rest \|\n\| 9 \| Bike \| Run \| Swim \| Rest \| Run \| Bike \| Rest \|\n\| 10 \| Run \| Swim \| Bike \| Rest \| Run \| Swim \| Rest \|\n\| 11 \| Bike \| Run \| Swim \| Rest \| Run \| Bike \| Rest \|\n\| 12 \| Run \| Swim \| Bike \| Rest \| Run \| Swim \| Rest \|\n\| 13 \| Bike \| Run \| Swim \| Rest \| Run \| Bike \| Rest \|\n\| 14 \| Run \| Swim \| Bike \| Rest \| Run \| Swim \| Rest \|\n\| 15 \| Bike \| Run \| Swim \| Rest \| Run \| Bike \| Rest \|\n\| 16 \| Run \| Swim \| Bike \| Rest \| Run \| Swim \| Rest \|\n\| 17 \| Bike \| Run \| Swim \| Rest \| Run \| Bike \| Rest \|\n\| 18 \| Run \| Swim \| Bike \| Rest \| Run \| Swim \| Rest \|\n\| 19 \| Bike \| Run \| Swim \| Rest \| Run \| Bike \| Rest \|\n\| 20 \| Run \| Swim \| Bike \| Rest \| Run \| Swim \| Rest \|\n\| 21 \| Bike \| Run \| Swim \| Rest \| Run \| Bike \| Rest \|\n\| 22 \| Run \| Swim \| Bike \| Rest \| Run \| Swim \| Rest \|\n\| 23 \| Bike \| Run \| Swim \| Rest \| Run \| Bike \| Rest \|\n\| 24 \| Run \| Swim \| Bike \| Rest \| Run \| Swim \| Rest \|\n\| 25 \| Triathlon!',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692822867495',
        content:
            '# How to Prepare for a Half Ironman\n## Step 6: Train for the Weather\n- \*\*Warm weather:\*\* Hydrate early and often\.\n- \*\*Cold weather:\*\* Dress in layers and avoid cotton\.\n- \*\*Windy weather:\*\* Protect your face and ears\.\n- \*\*Rainy weather:\*\* Stay hydrated and avoid puddles\.',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692822870254',
        content:
            '# How to Prepare for a Half Ironman\n## Step 7: Deal with Setbacks\n- Expect challenges, plan for contingencies\.\n- Stay positive, don’t let setbacks derail you\.',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692822872967',
        content:
            '# Half Ironman Prep\n## Step 8: Taper & Race Day\n- Ease back on training\.\n- Hydrate and fuel well\.\n- Rest and visualize success\.',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692822874643',
        content:
            '# Conclusion & Q&A\n## Final Thoughts\n- Half Ironman requires 6-12 months of training\.\n- Train for endurance, speed, and strength\.\n- Plan your nutrition and taper\.\n- Enjoy the journey!\n## Q&A',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
    ];
