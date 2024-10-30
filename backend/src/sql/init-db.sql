
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Articles;
DROP TABLE IF EXISTS Likes;


CREATE TABLE Users (
    id INTEGER NOT NULL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    firstName TEXT,
    lastName TEXT,
    password TEXT NOT NULL,
    blurb TEXT,
    selectedAvatar TEXT,
    email TEXT NOT NULL UNIQUE,
    dob DATE NOT NULL
);


CREATE TABLE Articles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    content TEXT NOT NULL,
    image TEXT NOT NULL,
    userId INTEGER NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (userId) REFERENCES Users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
CREATE TABLE Likes (
    id INTEGER PRIMARY KEY,  
    user_id INTEGER,
    article_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (article_id) REFERENCES Articles(id) ON DELETE CASCADE
);



INSERT INTO Users (username, firstName, lastName, password, blurb, selectedAvatar, email, dob)
VALUES
    ('john_doe', 'John', 'Doe', '$2b$10$fhC03I3hcXX9alkDeES/suyoXtMTqNTxXOS1VZXqoGHcWfXjtGK5O', 'I love coding', 'avatars/avatar1.png', 'john.doe@example.com', '1990-01-15'),
    ('jane_smith', 'Jane', 'Smith', '$2b$10$fhC03I3hcXX9alkDeES/suyoXtMTqNTxXOS1VZXqoGHcWfXjtGK5O', 'Coffee enthusiast', 'avatars/avatar2.png', 'jane.smith@example.com', '1992-06-20'),
    ('michael_brown', 'Michael', 'Brown', '$2b$10$fhC03I3hcXX9alkDeES/suyoXtMTqNTxXOS1VZXqoGHcWfXjtGK5O', 'Tech geek', 'avatars/avatar3.png', 'michael.brown@example.com', '1988-11-30'),
    ('lisa_wong', 'Lisa', 'Wong', '$2b$10$fhC03I3hcXX9alkDeES/suyoXtMTqNTxXOS1VZXqoGHcWfXjtGK5O', 'Art lover', 'avatars/avatar4.png', 'lisa.wong@example.com', '1995-07-14'),
    ('david_jones', 'David', 'Jones', '$2b$10$fhC03I3hcXX9alkDeES/suyoXtMTqNTxXOS1VZXqoGHcWfXjtGK5O', 'Fitness addict', 'avatars/avatar5.png', 'david.jones@example.com', '1987-04-22');


INSERT INTO Articles (title, description, content, image, userId, date) VALUES

(
    '10 Days in Bali: A Journey of Discovery',
    'Exploring the hidden gems of Indonesia''s paradise island',
    '<p>Bali, known as the "Island of the Gods", is famous for its stunning landscapes, which include lush rice terraces, volcanic mountains, and beautiful beaches. The island is a cultural hub, rich in traditions and arts, with vibrant markets and exquisite temples that showcase its deep spiritual heritage. Bali attracts travelers from around the world with its warm hospitality, offering a wide range of accommodations from luxury resorts to cozy guesthouses.</p>
    
    <p>Adventure seekers can enjoy activities like surfing, snorkeling, and hiking to the summit of Mount Batur for breathtaking sunrise views. The local cuisine, featuring dishes such as nasi goreng and satay, tantalizes the taste buds and reflects the island''s diverse culinary influences. From pristine beaches to lush rice terraces, Bali offers a diverse landscape that captivates every traveler. Our 10-day adventure took us through bustling markets, serene temples, and breathtaking sunsets.</p>',
    '8.jpg',
    1,
    '2024-10-01'
),
(
    'The Ultimate Guide to Backpacking Europe',
    'Tips and tricks for budget-friendly travel across the continent',
    '<p>Embarking on a backpacking trip through Europe? Our comprehensive guide covers everything from planning your route to finding the best hostels and hidden local spots in each city. Backpacking through Europe is a thrilling adventure that offers travelers the chance to explore diverse cultures, historic sites, and breathtaking landscapes. With a well-planned itinerary, you can traverse countries like Italy, France, and Spain, each boasting unique attractions and experiences.</p> 
    <p>Start your journey in iconic cities such as Paris and Rome, where world-renowned landmarks like the Eiffel Tower and the Colosseum await. Use budget-friendly transportation options, like trains and buses, to make your way across the continent. Staying in hostels not only cuts costs but also provides opportunities to meet fellow travelers and share stories, tips, and itineraries. As you navigate through Europe, embrace the local cuisine by trying street food and dining at family-run eateries. Don''t miss out on exploring lesser-known towns and villages, where you can immerse yourself in the authentic culture and traditions of the region. Take advantage of free walking tours to gain insights into the history and significance of each location. Remember to pack light, carry a reliable backpack, and have a flexible mindset; sometimes the best adventures come from unplanned detours. With its rich tapestry of art, history, and natural beauty, backpacking Europe promises unforgettable memories that will last a lifetime.</p>',
    '20.jpg',
    2,
    '2024-09-15'
),
(
    'Sustainable Travel: Eco-Friendly Adventures in Costa Rica',
    'Discover how to explore while minimizing your environmental impact',
    '<p>Costa Rica is a tropical paradise renowned for its stunning biodiversity and commitment to environmental sustainability. Nestled between the Pacific Ocean and the Caribbean Sea, the country boasts lush rainforests, pristine beaches, and a variety of ecosystems teeming with wildlife. Adventurers can explore the rugged terrain through hiking trails in national parks like Manuel Antonio and Arenal, where breathtaking waterfalls and active volcanoes await.</p>
    <p>The country is also a haven for eco-tourism, offering opportunities for zip-lining, surfing, and snorkeling in vibrant coral reefs. Beyond its natural beauty, Costa Rica''s friendly locals and rich culture, including delicious cuisine and traditional music, create an inviting atmosphere that enchants visitors from around the globe.</p>',
    '3.jpg',
    3,
    '2024-01-15'
),
(
    'Culinary Journey Through Southeast Asia',
    'A food lover''s guide to the flavors of Thailand, Vietnam, and Malaysia',
    '<p>Embark on a mouthwatering adventure through the street markets and local eateries of Southeast Asia. From pad thai in Bangkok to pho in Hanoi, discover the region''s most iconic dishes.From the spicy street food of Thailand, like pad thai and green curry, to the fragrant pho of Vietnam, each dish tells a story of its origins and ingredients. Markets buzz with energy as vendors showcase fresh produce, herbs, and spices, inviting travelers to savor local delicacies and try their hand at cooking classes. The fusion of flavors in dishes such as Malaysian laksa and Indonesian rendang highlights the region''s unique blend of influences, including Indian, Chinese, and indigenous traditions. Whether dining in a bustling hawker center or enjoying a meal in a family-run restaurant, the culinary experiences in Southeast Asia are not just about food—they are a celebration of community, culture, and the joy of sharing meals with loved ones.In addition to iconic dishes, Southeast Asia offers a delightful array of street food that showcases the ingenuity and creativity of local cooks. Sampling snacks like Filipino lumpia, crispy Thai spring rolls, and Indonesian satay provides an authentic taste of the region’s culinary heritage.</p>
    <p> Markets often feature food stalls where travelers can experience the lively atmosphere and interact with friendly vendors, who are eager to share their recipes and cooking tips. Beyond savory dishes, desserts like Thai mango sticky rice and Vietnamese che add a sweet finish to any meal, highlighting the region''s love for fresh, tropical ingredients. Embracing the culinary journey in Southeast Asia is not just about indulging in delicious food; it’s about connecting with the people, traditions, and vibrant cultures that make each meal memorable.</p>',
    '9.jpg',
    4,
    '2024-08-01'
),

(
    'A Journey Through Time: The Colosseum',
    'Exploring the iconic heart of ancient Rome',
    '<p>The Colosseum, an enduring symbol of Rome, stands as a testament to the grandeur of the Roman Empire. This ancient amphitheater, built in AD 70-80, has witnessed countless events, from gladiatorial contests to public spectacles. Stepping inside its massive stone arches, visitors can almost hear the roar of the crowd that once filled its seats. nAs you explore this architectural marvel, you''ll learn about its innovative construction techniques, including the use of concrete and the complex system of vaults that enabled its grand scale.</p>
    <p> The Colosseum could hold up to 80,000 spectators, who came to witness the dramatic battles between gladiators and wild animals. Imagine the thrill and excitement that must have filled the air! Today, visitors can walk along the ancient stone pathways and envision the spectacles that once captivated audiences. The site''s significance extends beyond its physical structure; it symbolizes the might of Rome and its influence on architecture and culture throughout history. As you gaze at the ruins, consider the many stories embedded within its walls—the triumphs and tragedies, the glory and the bloodshed.
    <p> In addition to its historical importance, the Colosseum is situated in the heart of Rome, making it an excellent starting point for exploring the city. Nearby attractions include the Roman Forum and Palatine Hill, both rich in history and archaeological significance. Don’t miss the chance to wander through these ancient ruins, where the remnants of temples and public buildings tell the tales of a once-thriving civilization. Visiting the Colosseum is not just about marveling at its structure; it’s about immersing yourself in the history that shaped the modern world. A guided tour can enrich your experience, providing insights into the stories and legends surrounding this iconic landmark. As the sun sets, the Colosseum takes on a magical quality, beautifully illuminated and standing proud against the Roman skyline. Plan your visit to ensure you capture the essence of this remarkable site.</p>',
    '1.jpg',
    1,
    '2024-11-05'
),
(
    'Mysteries of Stonehenge: An Ancient Marvel',
    'Unraveling the enigma of the prehistoric monument',
    '<p>Stonehenge, with its massive standing stones arranged in a circular layout, has captivated the imagination of visitors for centuries. Located on the Salisbury Plain in England, this prehistoric monument dates back to around 3000 BC, making it one of the most famous archaeological sites in the world. Its purpose remains shrouded in mystery, sparking theories about its significance in ancient rituals, astronomy, and social gatherings.</p>
    <p> As you approach Stonehenge, the sheer size of the stones commands attention. Some weigh as much as 25 tons, and it’s astonishing to consider how prehistoric people transported and erected such colossal structures without modern technology. Recent studies suggest that Stonehenge may have served as a burial site, a place of healing, or even an astronomical observatory. The alignment of the stones with the solstices suggests that the site played a crucial role in ancient agricultural practices, marking the changing seasons. Walking among the stones, you can almost feel the weight of history surrounding you. The landscape itself adds to the experience; the rolling hills and lush green fields create a serene atmosphere that invites contemplation. The site is part of a UNESCO World Heritage Site and is protected to preserve its integrity for future generations. Visitors to Stonehenge can explore the surrounding areas, including the visitor center, which offers exhibits on the history and significance of the site. Interactive displays and informative panels provide context, allowing you to delve deeper into the theories surrounding Stonehenge’s construction and purpose. Whether you visit at dawn to catch the sunrise illuminating the stones or during a summer solstice celebration, Stonehenge leaves a lasting impression. It invites questions about our past and how our ancestors connected with the earth and the cosmos. As you stand among these ancient giants, you become part of the ongoing dialogue about human history, culture, and the mysteries that continue to intrigue us today.</p>',
    '2.jpg',
    2,
    '2024-11-12'
),
(
    'Tropical Paradise: Discovering the Maldives',
    'A journey through crystal-clear waters and vibrant coral reefs',
    '<p>The Maldives, a tropical paradise in the Indian Ocean, is renowned for its stunning beauty, with over 1,000 coral islands and an abundance of marine life. This idyllic destination offers a unique blend of luxury and adventure, making it a favorite for honeymooners, families, and travelers seeking relaxation. Upon arrival, visitors are greeted by the mesmerizing shades of turquoise waters, which invite you to explore their depths. The Maldives is home to some of the most vibrant coral reefs in the world, teeming with colorful fish, turtles, and even manta rays. Snorkeling and scuba diving here are not just activities; they are transformative experiences that allow you to witness the incredible underwater ecosystems up close. Many resorts offer guided dives and snorkeling excursions, ensuring that even beginners can appreciate the beauty of this underwater world. Beyond the beaches and water sports, the Maldives offers a glimpse into local culture. </p>
    <p>Explore the capital city, Malé, where you can visit the local market, the Grand Friday Mosque, and the National Museum. Here, you’ll discover the rich history of the Maldives, from its early settlements to its current status as a global tourist destination. Interacting with locals provides a deeper understanding of their way of life and traditions. The Maldives is also a haven for wellness and relaxation. Many resorts feature luxurious spa facilities, offering treatments inspired by local healing traditions. Imagine indulging in a soothing massage while overlooking the ocean waves or practicing yoga on a secluded beach at sunrise. The tranquil environment encourages mindfulness and rejuvenation, making it a perfect retreat for those looking to escape the stresses of everyday life. </p>
    
    <p>As the day winds down, the Maldives transforms into a magical setting. Picture yourself dining on a private beach under a starlit sky, enjoying fresh seafood and local delicacies. The warmth of the sand beneath your feet and the sound of gentle waves create an unforgettable dining experience. Whether you’re seeking adventure, relaxation, or cultural immersion, the Maldives promises an extraordinary journey. This tropical paradise invites you to create memories that will last a lifetime, leaving you with a profound appreciation for its natural beauty and cultural richness.</p>',
    '5.jpg',
    3,
    '2024-11-19'
),
(
     'The Wonders of New Zealand: Nature at Its Best',
    'Adventure in the Land of the Long White Cloud',
    '<p>New Zealand, often referred to as the "Land of the Long White Cloud," offers a breathtaking array of natural wonders, from majestic mountains to pristine beaches. Whether you’re exploring the geothermal landscapes of Rotorua or the stunning fjords of Milford Sound, each destination presents unique experiences that captivate the senses. </p>
    <p>A journey through the North Island reveals vibrant cities like Auckland and Wellington, where you can immerse yourself in Maori culture and savor delicious local cuisine. Outdoor enthusiasts will find paradise in places like Queenstown, known for its adrenaline-pumping activities, including bungee jumping, skydiving, and hiking the scenic trails of the Remarkables. In addition to its dramatic landscapes, New Zealand is home to rich wildlife, with opportunities to spot unique species like the kiwi and the Hector’s dolphin. The country’s commitment to conservation is evident in its numerous national parks and protected areas, which allow visitors to connect with nature in a sustainable way. </p>
    <p>As you travel through this enchanting land, the warmth of its people and the allure of its scenery will leave you with unforgettable memories that will beckon you to return.</p>',
    '7.jpg',
    1,
    '2024-11-10'
),
(
    'Exploring the Vibrant City of Phoenix, Arizona',
    'A journey through the heart of the Valley of the Sun',
    '<p>Phoenix, the capital city of Arizona, is a bustling metropolis that offers a unique blend of urban sophistication and stunning desert landscapes. Nestled in the Sonoran Desert, this vibrant city is known for its year-round sunshine, making it a perfect destination for outdoor enthusiasts and urban explorers alike. With a thriving arts scene, delicious culinary offerings, and numerous recreational opportunities, Phoenix has something for everyone. As you wander through downtown, you’ll discover a variety of cultural attractions, including the Phoenix Art Museum and the Heard Museum, which showcases Native American art and history.</p> 
    <p>The city’s diverse neighborhoods, such as Roosevelt Row, are filled with colorful murals and local boutiques, creating a lively atmosphere that reflects the city’s creative spirit. Outdoor lovers can escape the urban hustle by exploring the nearby Camelback Mountain or South Mountain Park, where hiking trails offer breathtaking views of the city and the surrounding desert. </p>
    <p>Food lovers will delight in Phoenix’s culinary scene, which features everything from traditional Mexican cuisine to innovative farm-to-table restaurants. Don’t miss the chance to try local favorites like Sonoran hot dogs and prickly pear margaritas. As the sun sets, the city comes alive with nightlife options, including live music venues, bars, and rooftop lounges that provide stunning views of the city skyline. Whether you’re seeking adventure, culture, or relaxation, Phoenix is a dynamic destination that captivates visitors with its unique charm.</p>',
    '4.jpg',
    1,
    '2024-11-15'
),
(
    'Paradise Found: Exploring the Beauty of Fiji',
    'A journey through turquoise waters and vibrant culture',
    '<p>Fiji, an archipelago of over 300 islands, is renowned for its stunning beaches, crystal-clear waters, and warm hospitality. This tropical paradise invites travelers to experience its breathtaking natural beauty and rich cultural heritage. From the moment you arrive, you are greeted with the enchanting sights of swaying palm trees, colorful coral reefs, and vibrant marine life that beckon for exploration. </p>
    <p>The islands offer a plethora of activities, including snorkeling and diving in some of the world’s most pristine coral reefs, where you can encounter diverse marine species and explore underwater landscapes. For those seeking relaxation, the white sandy beaches provide the perfect backdrop for unwinding under the sun or enjoying a traditional Fijian massage at a luxury resort. Beyond the beaches, immerse yourself in the local culture by visiting traditional villages, where you can participate in a kava ceremony and learn about the customs and traditions of the Fijian people. </p>
    <p>The warmth and friendliness of the locals make every interaction memorable. As the day winds down, enjoy a sunset cruise or a beachside dinner, where fresh seafood and tropical fruits showcase the island’s culinary delights. With its stunning landscapes and vibrant culture, Fiji promises an unforgettable escape that will linger in your heart long after you leave.</p>',
    '12.jpg',
    2,
    '2024-11-20'
),
(
    'A Culinary Adventure in Singapore',
    'Exploring the Diverse Flavors of the Lion City',
    '<p>Singapore, a bustling metropolis, is a melting pot of cultures, and nowhere is this more evident than in its vibrant food scene. From hawker centers to fine dining, Singapore offers an array of culinary delights that reflect its multicultural heritage. At the heart of Singapore\''s food culture is the hawker center, where you can savor local dishes like Hainanese chicken rice, laksa, and chili crab—all at affordable prices. Each stall tells a story, often passed down through generations.</p> 
    <p>As you navigate the maze of flavors, don''t miss out on the famous Maxwell Food Centre, where the aroma of street food fills the air, inviting you to indulge. For a different experience, take a stroll down Orchard Road, Singapore''s shopping paradise, where you’ll find high-end restaurants serving international cuisine. Here, you can enjoy a luxurious meal while soaking in the vibrant atmosphere. Beyond food, Singapore''s attractions like Gardens by the Bay and the iconic Marina Bay Sands provide stunning backdrops for your culinary journey. As the sun sets, the city lights up, offering a magical ambiance to enjoy a meal outdoors. Whether you’re a foodie or simply looking to explore, Singapore promises a culinary adventure that tantalizes the taste buds and leaves lasting memories.</p>',
    '10.jpg',
    3,
    '2024-11-05'
),
(
    'Majestic Landscapes of Switzerland',
    'Discovering the Beauty of the Swiss Alps',
    '<p>Switzerland, known for its breathtaking landscapes and picturesque villages, is a dream destination for nature lovers and adventure seekers alike. The Swiss Alps dominate the skyline, offering stunning views, world-class skiing, and charming alpine towns. Begin your journey in Zermatt, a car-free village at the foot of the iconic Matterhorn. Here, you can take a cable car up to the Klein Matterhorn for panoramic views of the surrounding peaks. In winter, the area transforms into a skiing paradise, while summer invites hikers to explore the myriad trails that weave through lush meadows.</p>
    <p> Another must-visit is Lucerne, famous for its preserved medieval architecture and stunning lake views. The Chapel Bridge, adorned with flowers, provides a scenic backdrop for photos, and a boat ride on Lake Lucerne offers a serene experience surrounded by majestic mountains. For a taste of Swiss culture, don’t miss out on fondue and chocolate. Visit a local chocolatier in Zurich or indulge in a traditional cheese fondue in a cozy mountain restaurant. As you traverse this beautiful country, from the bustling cities to tranquil lakes and towering mountains, Switzerland''s charm will captivate your heart, leaving you yearning to return.</p>',
    '6.jpg',
    4,
    '2024-11-05'
);
