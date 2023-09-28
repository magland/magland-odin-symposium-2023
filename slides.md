---
marp: true
paginate: true
theme: magland-theme
footer: Magland ODIN Symposium 2023
---

<!-- For using custom theme, see https://github.com/orgs/marp-team/discussions/115 -->

# Web-based visualization and analysis of neurophysiology data

Jeremy Magland, Center for Computational Mathematics, Flatiron Institute

With:

* Flatiron Institute: Jeff Soules
* Frank lab: Loren Frank, Eric denovellis, Kyu Hyun Lee, Alison Comrie, Michael Coulter
* CatalystNeuro: Ben Dichter, Alessio Buccino, Luiz Tauffer, Cody Baker

---

## Why web-based software?

* **Easy to use:** no installation
* **Easy to share:** copy-paste the link
* **Advantages for the developer:** no need to worry about installation, cross-platform compatibility, etc.
* **Limitations:** no native access to local files/software, requires internet connection, limited access to previous versions, requires coding in javascript/typescript

---

## Three web-based tools for neurophysiology visualization and analysis

* [Figurl](https://github.com/flatironinstitute/figurl): framework for creating shareable interactive visualizations
* [Neurosift](https://github.com/flatironinstitute/neurosift): static web app for visualizing NWB files hosted in the cloud (DANDI)
* [Protocaas](https://github.com/scratchrealm/protocaas2): web app for analyzing neurophysiology data in the cloud or using local compute resources

---

## Figurl: Goals

![bg right:25% 80%](https://user-images.githubusercontent.com/3679296/269425776-52d0eec8-35b4-40be-b5f1-44937265ba77.png)

- Simplify sharing of interactive web-based visualizations
    - Run a Python script to generate a shareable URL
    - Frictionless data sharing
- Enable creation of feature-rich interactive visualization plugins, especially for neuroscience
    - Distributed as static HTML bundles
    - React/typescript
- Promote scientific reproducibility

---

## Figurl: Plotly example

![bg right:35% 90%](https://github.com/magland/magland-fwam-2023/assets/3679296/e9b8a289-f91e-4902-ac6a-c00d2d7d5ad4)

```python
import plotly.express as px
import figurl as fig

# Load the iris dataset and create a Plotly figure
iris = px.data.iris()
ff = px.scatter_3d(iris, x='sepal_length',
		y='sepal_width', z='petal_width',
		color='species')

# Create and print the figURL
url = fig.Plotly(ff).url(label='plotly example - iris 3d')
print(url)

# Output: 
# https://figurl.org/f?v=gs://figurl/plotly-1
# &d=sha1://5c6ec276ce9a3b20b208aaff911b037ce4052e51
# &label=plotly%20example%20-%20iris%203d
```

[Figurl link](https://figurl.org/f?v=gs://figurl/plotly-1&d=sha1://5c6ec276ce9a3b20b208aaff911b037ce4052e51&label=plotly%20example%20-%20iris%203d)

---

## Figurl architecture

![bg: 80%](https://user-images.githubusercontent.com/3679296/269635248-6f9ee2b9-3217-4a8b-8338-a7535851a8a3.svg)

---

![figurl]()

* Framework for creating shareable interactive visualizations
* Uses a Python script to generate a shareable URL
* Goal: Frictionless data sharing

Figurl is a platform for creating and sharing interactive visualizations. From a Python script, users can create interactive browser-based figures that can immediately be shared simply by copy-pasting the link. The data needed for visualization is uploaded to the Kachery cloud and then retrieved by the browser to render using a custom visualization. Each domain-specific visualization plugin is a static HTML bundle that has been built using ReactJS / typescript. This plugin is embedded into the main figurl web application within an HTML iframe.

In addition to managing the flow of data from the cloud to the visualization, Figurl also handles advanced capabilities of the figure, such as user login for curation, GitHub integration, and lazy loading of additional data objects requested by the visualization plugin.

---

## Static web apps

* **Easy to deploy**: For example, host on GitHub pages
* **Easy to maintain**: No server-side components
* **Cons:** no persistent data, no server-side processing
* But there's a lot you can do without a backend, especially if data are available in the cloud (DANDI)

<!-- ## Role of visualization in the scientific process

![bg right:20% 40%](https://upload.wikimedia.org/wikipedia/commons/5/55/Magnifying_glass_icon.svg)

Visualization is critical at every stage of the data-centric scientific process

- Data exploration
- Data cleaning and quality control
- Analysis and interpretation
- Communication of results to scientific community -->

---

## Benefits of interactive visualizations

Compared with static plots, interactive visualizations enable:

- Exploration of large, complex datasets
- Rapid identification of outliers and artifacts
- Interactive hypothesis testing

---

## Current limitations in sharing interactive visualizations

Interactive visualizations are not easily shared as they often require:

- Specialized operating system / hardware
- Specialized software
- Transfer of large datasets
- Expertise in setting up the visualization

---

## Advantages of browser-based approaches

- Platform independence
- No software installation or upgrades
- Opportunity for collaboration (link sharing)

---

## Executable notebooks (browser-based solution)

![bg right:50% 90%](https://github.com/magland/magland-fwam-2023/assets/3679296/e83cfb54-12a5-49e9-a92f-ec1a1e8dd5a8)

- Jupyter, Google Colab, etc.
- Pros: reproducible, interactive, shareable static rendered notebooks
- Cons:
    - Requires a running backend
    - Not easy to share interactive visualizations
    - Cluttered by code

---

## Clickable hyperlink approach

![bg right:50% 90%](https://i0.wp.com/blog.eyewire.org/wp-content/uploads/2017/10/example_bundle_pyramidal.png?w=666&ssl=1)

- Example: [Neuroglancer](https://github.com/google/neuroglancer)
- Dissemination using URLs
- No backend server required (client-side computation)
- [Open viewer](https://neuroglancer-demo.appspot.com/#!{'layers':{'image':{'type':'image'_'source':'precomputed://gs://neuroglancer-public-data/flyem_fib-25/image'}_'ground-truth':{'type':'segmentation'_'source':'precomputed://gs://neuroglancer-public-data/flyem_fib-25/ground_truth'_'segments':['21894'_'22060'_'158571'_'24436'_'2515']}}_'navigation':{'pose':{'position':{'voxelSize':[8_8_8]_'voxelCoordinates':[2914.500732421875_3088.243408203125_4045]}}_'zoomFactor':30.09748283999932}_'perspectiveOrientation':[0.3143535554409027_0.8142156600952148_0.4843369424343109_-0.06040262430906296]_'perspectiveZoom':443.63404517712684_'showSlices':false})

---

## Example Neuroglancer URL

![bg right:25% 90%](https://github.com/magland/magland-fwam-2023/assets/3679296/02d77daf-ccf9-458f-9feb-724905769690)

`https://neuroglancer-demo.appspot.com/#!{'layers':{'image':{'type':'image'_'source':'precomputed://gs://neuroglancer-public-data/flyem_fib-25/image'}_'ground-truth':{'type':'segmentation'_'source':'precomputed://gs://neuroglancer-public-data/flyem_fib-25/ground_truth'_'segments':['21894'_'22060'_'158571'_'24436'_'2515']}}_'navigation':{'pose':{'position':{'voxelSize':[8_8_8]_'voxelCoordinates':[2914.500732421875_3088.243408203125_4045]}}_'zoomFactor':30.09748283999932}_'perspectiveOrientation':[0.3143535554409027_0.8142156600952148_0.4843369424343109_-0.06040262430906296]_'perspectiveZoom':443.63404517712684_'showSlices':false}`

---

## Figurl: Architecture

<img src="https://user-images.githubusercontent.com/3679296/269635248-6f9ee2b9-3217-4a8b-8338-a7535851a8a3.svg" width="200%"></img>

---


---

## Kachery: content-addressable storage in the cloud

---

## Static plots (Altair, Plotly)

---

## Neuroscience examples

* Examples demonstrating Figurl's usefulness
* Application in various neuroscience scenarios
* Potential for adoption in other scientific fields

---

## Creating a Figurl visualization plugin

