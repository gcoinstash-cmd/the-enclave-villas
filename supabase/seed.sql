-- ==============================================================================
-- THE ENCLAVE — Ultra-Luxury Architectural Real Estate & Private Villa OS
-- Supabase Production Seed Data
-- ==============================================================================

INSERT INTO public.properties (id, title, description, price, location, bedrooms, bathrooms, sqft, images, status, amenities, broker_id)
VALUES
(
  'prop-001',
  'The Obsidian Pavilion',
  'A masterpiece of contemporary brutalism and Japanese-inspired Zen design. Concrete and charred cedar wood villa integrated into a windswept cliffside, featuring thermal floor-to-ceiling glass, a sunken fire pit lounge, and an oceanfront infinity pool.',
  8450000,
  'Big Sur, California',
  4,
  4.5,
  6200,
  ARRAY[
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=85',
    'https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&w=1200&q=85'
  ],
  'available',
  ARRAY['Oceanfront Clifftop', 'Charred Cedar Cladding', 'Private Onsen Pool', 'Sunken Conversation Pit', 'Tesla Solar Array', 'Professional Chef Kitchen'],
  'broker-alpha'
),
(
  'prop-002',
  'Minimalist Atrium House',
  'Conceived by award-winning architects, this single-story oasis is organized around a private interior courtyard featuring a solitary specimen maple tree. Raw board-formed concrete walls, structural limestone flooring, and concealed lighting tracks.',
  4200000,
  'Kyoto Highlands, Japan',
  2,
  2.0,
  3100,
  ARRAY[
    'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=1200&q=85',
    'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&w=1200&q=85'
  ],
  'available',
  ARRAY['Zen Maple Court', 'Board-Formed Concrete', 'Radiant Heated Stone', 'Dual Master Tea Suites', 'Smart Tinting Glazing'],
  'broker-alpha'
),
(
  'prop-003',
  'The Champagne Penthouse',
  'Occupying the entire top level of a boutique residential tower, this penthouse is designed with a champagne-anodized aluminum skeletal frame. Offers panoramic views of the skyline through custom curved glass corners, honed white travertine cladding.',
  12500000,
  'Tribeca, New York',
  3,
  3.5,
  4800,
  ARRAY[
    'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=85',
    'https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?auto=format&fit=crop&w=1200&q=85'
  ],
  'pending',
  ARRAY['Skydome Skylights', 'Travertine Wellness Spa', 'Helipad Access Portal', 'Private Wine Vault', 'Integrated Audio-Acoustics', 'Wrap-around Champagne Deck'],
  'broker-beta'
),
(
  'prop-004',
  'The Brutalist Sanctuary',
  'A striking statement of linear geometric forms situated within a lush private pine forest. Raw, exposed architectural steel beams flank high-density basalt tile workspaces and customized oak partitions.',
  6900000,
  'Sintra, Portugal',
  5,
  6.0,
  7400,
  ARRAY[
    'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=1200&q=85',
    'https://images.unsplash.com/photo-1613977257363-707ba9348227?auto=format&fit=crop&w=1200&q=85'
  ],
  'available',
  ARRAY['10-Acre Private Forest', 'Biometric Security Vault', 'Natural Cold Plunge Pool', 'Cantilevered Gym Capsule', 'Basalt-slab Flooring', 'Separate Staff Quarters'],
  'broker-beta'
)
ON CONFLICT (id) DO NOTHING;

-- Initial Seed Documents
INSERT INTO public.documents (id, title, file_url, client_id, broker_id, uploaded_by)
VALUES
('doc-001', 'Lease Agreement: The Obsidian Pavilion', 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf', 'mock-client-uid', 'broker-alpha', 'broker-alpha'),
('doc-002', 'Deed of Title Check: Minimalist Atrium', 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf', 'mock-client-uid', 'broker-alpha', 'broker-alpha')
ON CONFLICT (id) DO NOTHING;
