# Deploy — hrishitabapuram.com

Everything needed to go live is in this folder. No build step, no dependencies.

```
site/
  index.html      the whole site
  CNAME           www.hrishitabapuram.com — tells GitHub which domain to serve
  robots.txt
  sitemap.xml
  .nojekyll       stops GitHub Pages running Jekyll over the files
  assets/         images (see assets/README.txt)
  set-domain.sh   only needed if the domain ever changes
  DEPLOY.md       this file
```

## Deploy — GitHub Pages (~10 minutes)

You already have `github.com/hbapuram`, so a user site is the shortest path.
It gives you `https://hbapuram.github.io` for free, with HTTPS.

1. Create a **new public repo** named exactly `hbapuram.github.io`.
   The name is what makes it a user site — it must match your username.

2. From this folder:

```bash
cd site
git init
git add .
git commit -m "portfolio"
git branch -M main
git remote add origin https://github.com/hbapuram/hbapuram.github.io.git
git push -u origin main
```

3. In the repo → **Settings → Pages** → Source: *Deploy from a branch*,
   Branch: `main`, folder `/ (root)`. Save.

4. Wait ~60 seconds, then open `https://hbapuram.github.io`.

Every later change is just: edit `index.html`, then

```bash
git add . && git commit -m "update" && git push
```

Live again in under a minute.

### Custom domain — hrishitabapuram.com (registered with Wix)

The URLs in this bundle are **already set** to `https://www.hrishitabapuram.com`
and a `CNAME` file is already present. You do not need to run `set-domain.sh`;
it is kept only in case the domain ever changes.

Wix will not let you change a Wix-registered domain's nameservers. That is fine
— you keep DNS at Wix and point the records at GitHub.

**Step 1 — DNS at Wix.** Wix account → **Domains** → the **Domain Actions**
icon (⋯) next to hrishitabapuram.com → **Manage DNS Records**.

Under **A (Host)**, leave Host Name blank (that is the apex) and add four
records, one per IP:

```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

Delete or overwrite any A record Wix put there by default. If Wix's own IP
survives alongside GitHub's, the domain intermittently resolves to a Wix
parking page.

Under **CNAME (Aliases)**, add:

```
Host Name: www
Value:     hbapuram.github.io
```

That value is your GitHub Pages domain, not your custom one — no `https://`,
no trailing slash, no `www`.

Optional, for IPv6, add four AAAA records on the blank apex host:
`2606:50c0:8000::153`, `2606:50c0:8001::153`, `2606:50c0:8002::153`,
`2606:50c0:8003::153`.

**Step 2 — tell GitHub.** Repo → **Settings → Pages → Custom domain** → enter
`www.hrishitabapuram.com` → Save. GitHub already sees the CNAME file in the
repo, so this should match immediately. Wait for the DNS check to go green,
then tick **Enforce HTTPS**.

The certificate can take up to an hour. If the Enforce HTTPS box stays greyed
out, remove the custom domain, Save, re-add it, Save again — that forces the
certificate to regenerate.

GitHub redirects hrishitabapuram.com → www.hrishitabapuram.com automatically
once both are configured.

**Verify:**

```bash
dig www.hrishitabapuram.com +noall +answer
dig hrishitabapuram.com +noall +answer -t A
```

The apex should return the four GitHub IPs; www should chain to
hbapuram.github.io. Wix DNS changes usually propagate in 15 minutes to a few
hours, occasionally up to 48.

**One Wix gotcha.** If hrishitabapuram.com is currently attached to a Wix site,
detach it first or Wix keeps restoring its own records. And if "Manage DNS
Records" is missing from the ⋯ menu, the domain is connected by *pointing*
rather than held at Wix, and the records live with the original registrar
instead.

### Alternative: Netlify Drop

If you want it live in 30 seconds with no git at all: drag this whole folder
onto https://app.netlify.com/drop. You get a random subdomain instantly and can
rename it in site settings. Good for a preview link; GitHub Pages is better as
the permanent home.

## Changed in v6

- Shelf card hidden (`id="shelfCard"` carries the `hidden` attribute) — the
  markup and the `SHELF` array in the script are untouched, so removing the one
  attribute brings it straight back.
- Instagram link removed; kitchen caption now points to VSCO.
- Footer email and the *Talk to me about it* button are live `mailto:` links.
- Quantitative finance section replaced with **Keeping up** — Arc and TARA
  written up from the July 2026 CV, agentic skill chips, and a line about
  vibe-coded apps. Nav, graph node, edges, hero `Out[1]` and title updated.
- Career tabs: `certifications & teaching` split into `certifications` and
  `teaching & talks`. New talk entry links the recorded Coding and More session.
- CV detail folded in: 6% conversion lift, causal inference / A/B testing,
  automated retraining, Anthropic (DataCamp) Claude certification, SAS
  credential ID, CGI hackathon venue. IBM Generative AI Engineering removed —
  it is not on the July 2026 CV.
- No-JS fallback added — the page no longer renders blank if scripts fail.
- Headline is now in the HTML and re-typed by JS, rather than injected.
- Open Graph / Twitter cards, canonical URL, inline SVG favicon, JSON-LD
  Person schema, `fonts.gstatic.com` preconnect.
- Mobile nav now scrolls horizontally instead of disappearing under 860px.
- Tabs wired with `aria-controls` / `aria-labelledby`.
- Placeholder chip `[add another]` removed from side quests.

## Images

All images are already in `assets/` at web-ready sizes (nothing left to upload
except the social card). Swap any of them by overwriting the file with the same
name — no HTML edit needed. See `assets/README.txt` for the full map.

The hero uses two crops of the same Milan cafe photo: `avatar.jpg` (the tight
round crop beside the headline) and `portrait.jpg` (the wider frame the popup
opens). Replacing the hero photo means regenerating both.

## Still open

Blocking nothing, but worth closing:

1. `og-card.png` doesn't exist yet — social previews will show no image.
   Expected at `assets/og-card.png`, 1200x630.
2. First project card links to the GitHub profile, not the repo.
3. Book link is an Amazon search query, not a product page.
4. Talk year is still my guess (2023, from the Coding and More dates), and it
   is unconfirmed whether the video is public or unlisted.
5. No CV download (the CV file carries phone numbers and a different personal
   email, so it is not published by default).
6. Graph nodes remain mouse-only; the toolbar nav covers the same jumps.
7. CPQFRM is still listed under certifications — kept deliberately as a real
   credential, but flag it if the AI repositioning should hide it.
8. Two email addresses in play: `hbapuram06@gmail.com` is on the site,
   `hrishitabapuram@gmail.com` is on the CV. Pick one.
