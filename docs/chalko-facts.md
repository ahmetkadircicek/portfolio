# Chalko: project facts

The project page is `/projects/chalko`. The privacy and support pages are `/chalko/privacy` and `/chalko/support`.

Source material for the portfolio project page. Everything here is true of the app as of 17 October 2026.

## One line

Chalko is a Turkish pass-and-play party game for iPhone and iPad. One player draws a word on a real whiteboard or paper while their team guesses; the app only deals the words, runs the timer and keeps score.

## How it is played

- 2 to 4 fixed teams: Kırmızılar, Maviler, Yeşiller, Sarılar. A short draw animation picks the team that starts.
- Before the game: turn length (30, 45, 60, 90 or 120 s), number of rounds (3, 5, 8 or 10) and free passes per turn (0 to 5).
- **Bildi** (guessed) is +1. **Pas** (skip) is free until the turn's free passes run out, then each pass is −1. Scores can go negative.
- The word stays hidden until the drawer presses and holds the card; each new word peeks open for 1.5 s, so teammates cannot read it off the screen.
- When time runs out the app asks whether the last word was guessed in time. The turn summary lists every word, and a tap flips a mis-pressed Bildi or Pas.
- Teams with equal top scores share the win. "Rövanş" starts a rematch with the same settings and a new draw.
- Four difficulty levels: Çöp Adam (easy), Karalamacı (medium), Ressam (hard) and Dalí (impossible, abstract concepts only).
- 2,607 hand-curated Turkish words: 834 / 618 / 569 / 586 per level. Every level above Çöp Adam also mixes in 300 words from the level below, giving pools of 834 / 918 / 869 / 886.
- A word never repeats within a game, and words not seen in earlier games come first.

## Role, platform, dates, status

- Solo project: idea, product decisions, design and development by Ahmet Kadir Çiçek, built with AI coding assistants (Claude Code and Google Antigravity).
- iOS 17+, iPhone and iPad, portrait only. Turkish only. Free, offline, no ads, no accounts, no in-app purchases.
- Started 16 October 2026.
- Status: not released yet. The MVP is feature-complete and an internal TestFlight build is being prepared.

## Technology

- Swift and SwiftUI with the Observation framework (`@Observable`). One state machine drives every screen: setup → handoff → countdown → playing → summary → game over.
- The timer is derived from an end date polled every 200 ms, so pausing is exact. The game pauses itself when the app leaves the foreground.
- Word lists are bundled `.txt` files, one word per line, deduplicated at load with Turkish-locale lowercasing.
- `UserDefaults` holds the settings and a per-level history of seen words. No network calls, no personal data, a privacy manifest is included, and the App Privacy answer is "Data Not Collected".
- Sound: `AVAudioPlayer` on an ambient audio session (respects the silent switch and mixes with music already playing), 8 CC0 sounds from Kenney.nl. Haptics: `UIFeedbackGenerator`. Separate sound and haptics toggles.
- StoreKit review request after the third finished game.
- Project generated with XcodeGen.
- Testing: no unit tests. A UI test target automates the App Store screenshots, the game was play-tested in the Simulator on iPhone SE, iPhone 17 Pro Max and iPad Pro 13", and a shell script checks the word lists for duplicates and cross-level overlaps.

## Design decisions

- A chunky, cartoonish 3D style inspired by mobile party games: thick dark-ink outlines (#1A1240), hard drop shadows, and SF Rounded in its Black weight.
- Palette: board blue #3B7BFF, yellow #FFC93C, lime #7CF03A, danger red #E5243B. The team colors are red #FF5A5F, blue #3B7BFF, green #12B886 and yellow #FFC93C.
- The whole background takes the active team's color. Badges and rows on top use white with a colored dot, or lime when the team itself is yellow, so they stay readable on every team color.
- App icon: redesigned for the Chalko name; the files are in Marketing/Logo in the app repository. The earlier icon showed a white, ink-outlined "Tahtaya Kalk" wordmark on blue.
- Playful Turkish copy throughout, for example "Süre bitti, kalemler yere!" ("Time's up, pens down!").

## Hardest engineering problem

Dealing words without repeats. A word must never appear twice in one game, words nobody has seen in earlier games should come first, each level borrows a stable slice of the level below, and undo or summary edits must not put a seen word back in the deck.

- The fix: a per-game set of used words plus a per-level seen history in `UserDefaults`.
- Each new deck is built from words that are both unseen and unused in this game.
- When every word in a level has been seen, the history resets to just this game's words.
- If a list truly runs out mid-game, the game ends cleanly with a note instead of repeating.

A close second was keeping the word secret. The drawer holds the phone while teammates face the board, which led to the hold-to-reveal card with a short automatic peek.

## What I learned

- Curating beats volume. A quality pass flagged 127 words that were hard to draw or wrong for their level, and the lists shrank from 2,700 to 2,607. The "abstract words only in Dalí" rule made the levels feel distinct.
- Real-time timers should come from end dates, not from counting ticks.
- Party games need big targets, sound and haptic feedback, and forgiving corrections such as undo and summary edits.
- AI agents work best on mechanical work when it comes as written task files, with a separate build-and-review step afterwards.

## Screenshots

All are real iPhone 17 Pro Max Simulator captures (1320 × 2868). The site uses them framed like the other projects as `assets/images/chalko/chalko_screenshots_<n>.webp`, in this order.

| File | Title | Caption |
|---|---|---|
| 1_home.png | Play | The home screen: Play, a quick start with its settings underneath, and buttons for sound, haptics, settings and help. |
| 2_setup.png | Choose how hard | The four difficulty levels with their word counts, and the game's settings above the start button. |
| 3_turn.png | Whose turn is it? | The handoff screen after the opening draw: the starting team, a reminder to hide the phone and the live scoreboard. |
| 4_play.png | Draw it, don't say it | The play screen: the secret word, the countdown, the turn score, undo, and the Pas and Bildi buttons. |
| 5_time_up.png | Pens down | Time is up, and the team says whether the last word was guessed in time. |
| 6_summary.png | Fix a mis-tap | The turn summary lists every word; a tap flips Bildi and Pas and the score updates. |
| 7_game_over.png | And the winner is | The final scores with a rematch button. |
| 8_help.png | The rules in one card | The how-to-play card, shown automatically on first launch. |
| icon.png | App icon | 1024 × 1024 App Store icon. |
