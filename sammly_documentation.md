### Abstract 
The field of interior design has long been characterized by high costs, time-consuming processes, and a reliance on professional expertise, creating a significant barrier for average homeowners. While the emergence of Artificial Intelligence (AI) has introduced new possibilities for design visualization, existing global applications often act merely as basic filters, failing to provide precise control over design elements or lacking cultural relevance to specific local markets, particularly in Egypt. 

This project introduces "Sammly," an AI-powered mobile application developed using the Flutter framework, designed to democratize access to professional-grade interior design tools. The system leverages state-of-the-art Generative AI and Computer Vision technologies to enable users to visualize, transform, and execute their living space ideas. Sammly offers comprehensive functionality, including **Text-to-Image** generation from scratch, **Image-to-Image** analysis for room restyling, and targeted **Inpainting** capabilities for intelligent object removal. 

To bridge the gap between digital ideation and physical execution, Sammly introduces **Smart Lens**, a visual search feature that identifies furniture within generated designs and connects users with similar real-world products. Furthermore, Sammly addresses a critical gap in the market by integrating a community-centric **"Explore"** section, fostering a platform for sharing inspiration and earning rewards. By combining the accessibility of mobile computing with the power of generative models, Sammly provides a robust, user-friendly solution that transforms architectural visualization into an interactive, personal, and actionable creative process.

---

### Chapter 1: Introduction 

#### 1.1 Overview 
The field of interior design has traditionally required significant time, budget, and professional expertise. Sammly is an AI-powered mobile application designed to democratize this process by leveraging artificial intelligence to assist users in visualizing and creating interior spaces. The system allows users to interact with advanced design tools through a user-friendly interface, enabling them to register accounts, securely log in, and effortlessly manage their creative workflow. 

The core functionality revolves around generating unique interior designs based on user inputs, such as text-based prompts (generating from scratch) or uploaded room images (restyling existing spaces). Beyond simple generation, Sammly provides surgical editing tools like object removal and a "Smart Lens" feature to locate real-world furniture equivalents. The application also fosters a community experience by providing an "Explore" section where users can browse, favorite, and interact with shared design styles. By combining visual analysis and generative AI, the project bridges the gap between professional design standards and accessible user tools.

#### 1.2 Problem Statement 
Many individuals struggle to visualize how different furniture, colors, or styles would look in their actual living spaces without hiring expensive professionals. The current market lacks comprehensive tools that combine: 
1. **Ease of Use:** Users often find professional 3D design software excessively complex and difficult to navigate. 
2. **Personalization & Restyling:** Existing tools may not effectively analyze specific user environments, preventing homeowners from seamlessly restyling their actual physical rooms. 
3. **Targeted Visual Modification:** There is a critical need for systems that allow users to not just generate a flat image, but also intelligently modify it—specifically by removing unwanted elements from the environment without ruining the scene. 
4. **Item Discovery (The Execution Gap):** Users often generate or see designs they love but cannot identify or purchase the specific furniture or decor items depicted in the renderings. 
5. **User Incentives:** Users are rarely rewarded for contributing high-quality, inspiring content to platform communities. 

#### 1.3 Key Objectives 
The primary objective of this project is to develop a robust mobile application that solves the aforementioned problems through the following specific goals: 
*   **AI-Driven Design Generation:** To develop a system that generates photorealistic interior design images based on text prompts, or by analyzing uploaded room images to restyle them according to user preferences. 
*   **Interactive Editing (Object Removal):** To implement advanced inpainting functionality that allows users to surgically modify generated or uploaded designs by removing unwanted elements while maintaining the environmental integrity of the output. 
*   **Item Discovery (Smart Lens):** To utilize computer vision via a "Smart Lens" feature, enabling users to scan specific furniture and decor items detected within an image and instantly find similar, purchasable products in the real world.
*   **Personalized Experience & Curation:** To create a centralized system that allows users to save their favorite designs, track their generation history, and easily retrieve past inspirations. 
*   **Community & Reward Ecosystem:** To provide a social platform where users can explore community styles, interact with others' designs, and earn an initial allocation of free tokens upon registration, with opportunities to earn more by actively sharing their creations. 
*   **Security & Performance:** To ensure the system is highly available, secures user data and authentication via modern encryption, and maintains optimized performance during heavy image processing tasks.

---

### CHAPTER 2: Background & Related Work 

#### 2.1 Background 
The integration of Artificial Intelligence (AI) into the field of interior design represents a paradigm shift in how spaces are conceptualized, visualized, and executed. Traditionally, interior design has been a resource-intensive process requiring significant manual effort, professional expertise, and time. This section explores the theoretical background of the core technologies and concepts underpinning the proposed ”Sammly” system. 

#### 2.1.1 Challenges in Traditional Interior Design 
The traditional interior design process often involves multiple iterations of sketches, 2D drawings, and complex 3D modeling using software like AutoCAD or 3Ds Max. This workflow presents several barriers: 
*   **Visualization Gap:** Clients often struggle to visualize how furniture or color schemes will look in their actual space based on abstract samples or 2D floor plans. 
*   **High Cost and Time:** Professional rendering services are expensive and time-consuming, making high-quality personalized design inaccessible to the average homeowner. 
*   **Lack of Flexibility:** Making changes to a rendered design usually requires restarting the tedious rendering process, which heavily delays decision-making. 
*   **Difficulty in Sourcing:** Even when clients approve a specific rendering, finding and purchasing the exact real-world furniture pieces depicted in the 3D model can be a frustrating and highly manual process.

#### 2.1.2 Generative AI and Computer Vision 
To address these challenges, ”Sammly” leverages state-of-the-art Generative AI and Computer Vision technologies to create an interactive, end-to-end design experience. 
*   **Generative AI (GenAI):** This refers to algorithms (such as advanced Diffusion Models) capable of generating photorealistic imagery based on learned patterns from vast datasets. In Sammly, GenAI is utilized to synthesize complete room layouts, textures, and lighting from simple text prompts (**Text-to-Image**). Additionally, it allows users to completely redesign an existing physical space by uploading a photo and applying a new architectural style (**Restyle / Image-to-Image**). 
*   **Inpainting & Object Removal:** Sammly utilizes targeted AI inpainting techniques to give users precise control over their environments. This enables the intelligent removal of unwanted objects (e.g., erasing an outdated piece of furniture) by seamlessly reconstructing the background, ensuring the modified space looks natural and untouched.
*   **Computer Vision & Visual Search (Smart Lens):** To bridge the gap between digital ideation and real-world execution, the system employs computer vision for object detection and visual search. Through Sammly's **"Smart Lens"** feature, the app ”understands” the content of generated designs or user-uploaded images, isolating specific furniture pieces and instantly returning similar, purchasable real-world products.
*   **Community-Driven Curation:** Beyond raw AI processing, modern design ecosystems rely heavily on robust data management. Sammly incorporates an exploration and curation platform—allowing users to save favorites, browse history, and share AI-generated room concepts with a community—thereby creating a collaborative and continuously expanding library of inspiration.

---

### 4.2 Mobile Application 
The mobile application was developed to help users interact easily with the Sammly AI Interior Design system. Through the app, users can create accounts, generate custom room designs using AI, explore community creations, save their favorite styles, and track their design history. The user interface was crafted to be modern, visually engaging, and highly intuitive to ensure a seamless creative experience for all users. 

During the initial phase of development, the focus was on establishing a well-structured and maintainable architecture. Flutter was selected as the development framework due to its high performance, cross-platform support, rich UI capabilities, and strong community backing.   

The project follows a feature-based folder structure, where each module (e.g., authentication, generate, home, explore, profile) is separated into its own directory. This organization improves modularity, prevents tight coupling between unrelated components, and simplifies maintenance. The project utilizes various external dependencies to enhance functionality. These include packages for state management (`flutter_bloc`), networking (`dio`), secure local storage (`shared_preferences`, `hive`), responsive UI scaling (`flutter_screenutil`), and image processing (`image_picker`, `image_cropper`).

To ensure better scalability and testability, the project applies the principles of Clean Architecture, which separates the codebase into three distinct layers, as outlined in Table 12 below: 

**Table 12: Clean Architecture Layers**
| Layer | Description |
| :--- | :--- |
| **Presentation Layer** | Handles UI rendering and state management using the BLoC/Cubit pattern. |
| **Domain Layer** | Contains core business logic, use cases, and repository interfaces. |
| **Data Layer** | Manages data sources, API interactions, and strongly-typed data models. |

To connect the app with backend APIs efficiently, a clean and centralized API structure was implemented. All core logic for handling HTTP requests, response parsing, error handling, and token management was organized inside a dedicated `core/networking/` directory using the `DioHelper` class. This setup reduced code duplication, ensured consistency across API calls, and automatically handled edge cases such as global session expirations (e.g., automatically logging a user out if their token expires).

After setting up the API layer, a structured data modeling approach was applied using strongly-typed models to simplify and secure interactions with backend data. Each feature—such as generation, authentication, or favorites—has its own folder containing only the models relevant to that feature. This feature-based structure ensured modularity, improved code clarity, and allowed isolated development without affecting other parts of the app. Together with the API setup, this created a solid foundation for reliable data binding and scalable development. 

The user authentication system was the first major feature implemented, enabling sign-up, login, password management, and persistent sessions through backend integration. The focus was on input validation, secure token storage, and handling edge cases such as incorrect credentials and network failures. This established the foundation for secure access across the application. 

To enable users to create and interact with interior designs, a robust image generation and exploration system was implemented. The core feature allows users to submit prompts, select room types and styles, and generate AI-powered images. The results are handled asynchronously, ensuring the UI remains responsive. An optimistic state management approach was utilized for interactions like saving designs to favorites or liking community posts; the app instantly updates the UI (e.g., filling a heart icon) and synchronizes with the backend in the background, providing a fast, dynamic, and professional user experience. Furthermore, robust error handling mechanisms were integrated to gracefully handle corrupted or missing image URLs, preventing application crashes and ensuring smooth browsing.
