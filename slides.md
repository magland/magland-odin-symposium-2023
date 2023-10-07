---
marp: true
paginate: true
theme: magland-theme
footer: Magland ODIN Symposium 2023
---

<!-- For using custom theme, see https://github.com/orgs/marp-team/discussions/115 -->

## Web-based visualization and analysis of neurophysiology data

![bg right:30% 100%](https://user-images.githubusercontent.com/3679296/273382387-e0e76888-5edf-4b20-8a76-eeb02be434cc.png)

Jeremy Magland, Center for Computational Mathematics, Flatiron Institute

With:

- Flatiron Institute: Jeff Soules
- Frank lab: Loren Frank, Eric denovellis, Kyu Hyun Lee, Alison Comrie, Michael Coulter
- CatalystNeuro: Ben Dichter, Alessio Buccino, Luiz Tauffer, Cody Baker

ODIN Symposium 2023

https://github.com/magland/magland-odin-symposium-2023

---

## Why web-based software?

- **Easy to use:** no installation
- **Easy to share:** copy-paste the link
- **Cross-platform:** all desktop options and mobile
- **Development cycle advantages:** simplifies distribution, etc.
- **Integrates naturally with cloud resources:** e.g., DANDI
* **Limitations:** no native access to local files/software, requires internet connection, limited access to previous versions, requires coding in JavaScript

---

## Three web-based tools for neurophysiology visualization and analysis

- [Figurl](https://github.com/flatironinstitute/figurl): framework for creating shareable interactive visualizations
- [Neurosift](https://github.com/flatironinstitute/neurosift): static web app for visualizing NWB files hosted in the cloud (DANDI)
- [Protocaas](https://github.com/scratchrealm/protocaas2): prototype web app for analyzing neurophysiology data in the cloud (or with cluster/local compute)

---

## Figurl: overview

![bg right:25% 80%](https://user-images.githubusercontent.com/3679296/269425776-52d0eec8-35b4-40be-b5f1-44937265ba77.png)

- Creation of feature-rich interactive visualization plugins, especially for neuroscience
- Simplifies sharing of figures
    - Run a Python script to generate a shareable URL
- Custom visualization plugins
    - Static HTML bundles in the cloud
    - React/typescript
- Promotes scientific collaboration, communication, reproducibility

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

## Figurl / SpikeInterface integration (with Alessio)

<img src="https://user-images.githubusercontent.com/3679296/271273000-1cc5e88b-2a8b-4ae6-9076-938c76d59cf5.png" width="100%" >

---

## Figurl / SpikeInterface integration

```python
import spikeextractors as se

# Load the recording and sorting
recording, sorting = ...

# prepare SpikeInterface widget
widget = ...

# Prepare and print the figURL
url = widget.url(label='example')
print(url)
```

---

## Figurl / SpikeInterface integration ([figurl](https://figurl.org/f?v=gs://figurl/spikesortingview-10&d=sha1://8d61e59b2806cf927ca1bd265923c23f5c37b990&label=experiment1_Record%20Node%20104%23Neuropix-PXI-100.ProbeA-AP_recording1%20-%20kilosort2_5%20-%20Sorting%20Summary))

<img src="https://user-images.githubusercontent.com/3679296/271270920-8f10b747-bac7-4664-b8fd-bb6cd5867d18.svg" height="95%" />

---

## Figurl: Other examples (see gallery)

<image src="https://user-images.githubusercontent.com/3679296/271276312-886a4aec-f972-4d9c-a821-19a2ae3d0de2.png" width="95%" />


---

## Figurl: Other examples (see gallery)

<image src="https://user-images.githubusercontent.com/3679296/271276944-449ddb6a-d640-48b2-9ee3-655ecb82e2fd.png" width="95%" />

---

## Figurl: Other examples (see gallery)

<image src="https://user-images.githubusercontent.com/3679296/271277359-9622d633-c375-467c-9549-3a69ca1616d9.png" width="95%" />

---

## Figurl uses Kachery

![bg right:50% 100%](https://user-images.githubusercontent.com/3679296/271279738-995996c6-a545-4cf7-9f5d-5473ca302547.png)

Kachery is a Content Addressable Storage database in the cloud
- Download from anywhere
- Minimal configuration for upload
- Python client
- Command-line client
- Serverless deployment
- Organized into zones (labs can host zones / pay for storage)

Kachery provides the data storage and transfer for Figurl

---

## Storing kachery data

```bash
echo "test-content" > test_content.txt
kachery-cloud-store test_content.txt
# output:
# sha1://b971c6ef19b1d70ae8f0feb989b106c319b36230?label=test_content.txt
```

From Python

```python
uri = kcl.store_text('example text', label='example.txt')
# uri = "sha1://d9e989f651cdd269d7f9bb8a215d024d8d283688?label=example.txt"
```

---

## Retrieving kachery data

```bash
kachery-cloud-load sha1://b971c6ef19b1d70ae8f0feb989b106c319b36230
```

```python
w = kcl.load_text('sha1://d9e989f651cdd269d7f9bb8a215d024d8d283688?label=example.txt')

x = kcl.load_json('sha1://d0d9555e376ff13a08c6d56072808e27ca32d54a?label=example.json')

y = kcl.load_npy("sha1://bb55205a2482c6db2ace544fc7d8397551110701?label=example.npy")

z = kcl.load_pkl("sha1://20d178d5a1264fc3267e38ca238c23f3e2dcd5d2?label=example.pkl")
```
---

## Neurosift: overview

- Visualize / browse NWB files hosted on DANDI (and elsewhere)
- Also view local NWB files
- No installation required
- No server backend required (client-only)
- Efficiently read data lazily from HDF5 files (h5wasm fork)
- Similar to NWBWidgets

---

## Neurosift / DANDI integration

Browse to a DANDI NWB file and click to open in Neurosift

![neurosift dandi integration](https://user-images.githubusercontent.com/3679296/272268075-24a0a6b0-8e66-4334-a3f5-9c186cdfae8f.png)


---
## Neurosift: NWB file browser

<img src="https://user-images.githubusercontent.com/3679296/272936637-c20dec5c-57b4-4d89-a598-2aa83834c6db.png" height="90%" />

[link](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/c86/cdf/c86cdfba-e1af-45a7-8dfd-d243adc20ced)

---

## Neurosift: ElectricalSeries

<img src="https://user-images.githubusercontent.com/3679296/258136572-7a552496-b2a5-462b-bbf4-bf85de966a4c.png" height="80%" />

[link](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/c86/cdf/c86cdfba-e1af-45a7-8dfd-d243adc20ced&tab=neurodata-item:/acquisition/ElectricalSeries|ElectricalSeries&tab-time=0,0.05385543094453243,0.009716474540105546)

---

## Neurosift: lazy loading from remote HDF5 files

![bg right:30% 50%](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/WebAssembly_Logo.svg/600px-WebAssembly_Logo.svg.png)


Forked version of h5wasm that uses efficient/smart chunking optimized for reading HDF5 using WebAssembly and web workers.

[https://github.com/usnistgov/h5wasm](https://github.com/usnistgov/h5wasm)

[https://github.com/flatironinstitute/neurosift/tree/main/gui/src/pages/NwbPage/RemoteH5File/h5wasm](https://github.com/flatironinstitute/neurosift/tree/main/gui/src/pages/NwbPage/RemoteH5File/h5wasm)

---

## Neurosift: Raster plot (spike trains)

<img src="https://user-images.githubusercontent.com/3679296/257921972-ae07e2c4-a30e-4325-9fdf-e14e20309d09.png" height="70%" />

[link](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/c86/cdf/c86cdfba-e1af-45a7-8dfd-d243adc20ced&tab=view:RasterPlot|/units&tab-time=0.0018000000000029104,239.58180000000007,96.43037142857143)

---

## Neurosift: Synchronized views

<img src="https://user-images.githubusercontent.com/3679296/272945539-7215b424-2d86-4a90-805f-6b5363528262.png" width="20%" /> &nbsp; <img src="https://user-images.githubusercontent.com/3679296/257916088-dfb3e1b8-046d-4390-afac-657f9c3f930c.png" width="70%" />


---

## Neurosift: Peri-stimulus time histogram (PSTH)

<img src="https://user-images.githubusercontent.com/3679296/257919770-d889d459-9052-4ea0-b378-b6b5ad2fbf30.png" height="70%" />

[link](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/df3/e3f/df3e3f73-50ab-42b4-8827-82664ddd474a&tab=view:PSTH|/intervals/trials)

---

## Neurosift examples

https://github.com/flatironinstitute/neurosift/wiki/Neurosift-DANDI-Examples

Neurodata types: [ImageSegmentation](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/368/fa7/368fa71e-4c93-4f7e-af15-06776ca07f34&tab=neurodata-item:/processing/ophys/ImageSegmentation|ImageSegmentation) | [SpatialSeries](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/c86/cdf/c86cdfba-e1af-45a7-8dfd-d243adc20ced&tab=neurodata-items:neurodata-item:/acquisition/position_sensor0|SpatialSeries@view:X/Y|/acquisition/position_sensor0&tab-time=0,384,117.50619637750238) | [TwoPhotonSeries](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/368/fa7/368fa71e-4c93-4f7e-af15-06776ca07f34&tab=neurodata-item:/acquisition/TwoPhotonSeries1|TwoPhotonSeries&tab-time=10.098519662000001,6361.5098989352,750.7224614147053) | [TimeSeries](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/c86/cdf/c86cdfba-e1af-45a7-8dfd-d243adc20ced&tab=neurodata-item:/acquisition/ch_SsolL|TimeSeries&tab-time=43.82871078730636,95.27484222730642,72.51887941685835) | [TimeIntervals](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/cae/e8f/caee8f64-ebeb-439d-a3f4-e3380699b49f&tab=neurodata-item:/intervals/trials|TimeIntervals) | [PSTH](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/df3/e3f/df3e3f73-50ab-42b4-8827-82664ddd474a&tab=view:PSTH|/intervals/trials) | [ElectricalSeries](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/c86/cdf/c86cdfba-e1af-45a7-8dfd-d243adc20ced&tab=neurodata-item:/acquisition/ElectricalSeries|ElectricalSeries&tab-time=0,0.05385543094453243,0.009716474540105546) | [LabeledEvents](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/80d/c44/80dc4460-7652-4b88-97ce-69a7e8be5d60&tab=neurodata-item:/processing/behavior/RewardEventsLinearTrack|LabeledEvents&tab-time=5731.0227,10222.015166753623,9596.949592555065) | [ImageSeries](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/8cf/38e/8cf38e36-6cd8-4c10-9d74-c2e6be70f019&dandi-asset=https://api.dandiarchive.org/api/dandisets/000568/versions/0.230705.1633/assets/9fc5a60e-af09-4099-ac22-ee54211f55e4/&tab=neurodata-item:/acquisition/ImageSeriesTrackingVideo1|ImageSeries) | [RasterPlot](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/c86/cdf/c86cdfba-e1af-45a7-8dfd-d243adc20ced&tab=view:RasterPlot|/units&tab-time=0.0018000000000029104,239.58180000000007,96.43037142857143) | [Autocorrelograms](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/c86/cdf/c86cdfba-e1af-45a7-8dfd-d243adc20ced&tab=view:Autocorrelograms|/units) | [Images](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/368/fa7/368fa71e-4c93-4f7e-af15-06776ca07f34&tab=neurodata-item:/processing/ophys/SegmentationImages1|Images) | [BehavioralEvents](https://flatironinstitute.github.io/neurosift/?p=/nwb&url=https://dandiarchive.s3.amazonaws.com/blobs/645/10d/64510d67-fab1-45ab-abc3-b18c9738412c&tab=neurodata-item:/processing/behavior/behavioral_events|BehavioralEvents) | ...


---

## Neurosift: viewing local files

- Prerequisite: [NodeJS v16 or higher](https://nodejs.org/en/download)
- Install the neurosift Python package: `pip install --upgrade neurosift`
- Run the following command in a terminal window:

```bash
neurosift view-nwb /path/to/file.nwb
```

This will open a web browser window with the Neurosift web app pointing to a symlinked copy of your file. You can then browse the file and visualize its contents.

---

## Protocaas: overview

Protocaas is a **prototype** web-based tool for analyzing neurophysiology data in the cloud (or with cluster/local compute).

- Under heavy development with Ben Dichter and Luiz Tauffer (last couple of months)
- Enable labs to use cloud resources to run analysis pipelines on their data
- Also allow option of using local machines or compute clusters
- Starting with spike sorting, but will expand
- Tight integration with DANDI and NWB
- Uses SpikeInterface and SI spike sorter docker images

---

## Protocaas: spike sorting

- Step 1: Prepare NWB files, create a dandiset, upload raw data
- Step 2: Create a Protocaas project and import the dandiset
- Step 3: Launch spike sorting from the web GUI
    - Select algorithm and parameters
    - Can be configured to use cloud resources (AWS Batch), Slurm cluster, or local machine
- Step 4: Browse outputs using Neurosift
- Step 5: Upload outputs to dandiset
    - Upload job launched from Protocaas GUI, runs in cloud
    - Either upload to source dandiset or a new one

---

## Protocaas spike sorting: Create a project

![image](https://github.com/magland/magland-odin-symposium-2023/assets/3679296/4b53003f-263a-43c5-8075-7a83935a41d7)

<img src="https://github.com/magland/magland-odin-symposium-2023/assets/3679296/22a5ac60-0d8c-403c-a4e2-2f38ba54efbd" width="45%" />

---

## Protocaas spike sorting: Import the raw NWB files from DANDI

<img src="https://user-images.githubusercontent.com/3679296/272281764-e9aa69d8-72a2-49bc-ad4e-89b468b6d5d2.png" width=90% />

---

## Protocaas spike sorting: Import the raw NWB files from DANDI

- Protocaas project files point to objects in cloud storage
- The imported files are only pointers to the DANDI files

---

## Protocaas spike sorting: Select files for sorting

<img src="https://user-images.githubusercontent.com/3679296/272283703-280c4266-e264-489f-84d7-a9b94ec5607f.png" width="85%" />

---

## Protocaas spike sorting: Select sorting parameters

<img src="https://user-images.githubusercontent.com/3679296/272286137-f6beddb3-d5d3-4b5e-98db-5a9d08b48488.png" width="85%" />

---

## Protocaas spike sorting: Monitor running jobs

<img src="https://user-images.githubusercontent.com/3679296/272287040-9f41f3d3-08ee-4ea3-be49-0bf5d5cf05ce.png" width="85%" />

- Jobs are running on the compute resource (AWS, Slurm, or local machine)
- Monitor their status through the web GUI

---

## Protocaas spike sorting: Browse results in Neurosift

<img src="https://user-images.githubusercontent.com/3679296/272289041-d592c612-095f-4d23-a0ca-fbdb2e054933.png" width="95%" />

- When jobs complete, they upload results to a cloud bucket
- Output files are added to the Protocaas project (pointers to the cloud outputs)
- Protocaas project contains all provenance information

---

## Protocaas spike sorting: Upload results to DANDI

<img src="https://github.com/magland/magland-odin-symposium-2023/assets/3679296/0388fb04-67d7-43c7-9149-9f190340b59d" width="30%" />

<img src="https://github.com/magland/magland-odin-symposium-2023/assets/3679296/2fb3c0f8-ce3a-4ee0-a9de-d1d5837e6a9a" width="75%" />

---

## Protocaas spike sorting: Provenance stored in DANDI metadata

<img src="https://github.com/magland/magland-odin-symposium-2023/assets/3679296/a261bad0-0ba3-4072-a4a3-e0e6fae52f18" width="85%" />

---

## Protocaas: advantages

- Scalability: you can spike sort many sessions at once
- Reproducibility: use AWS and get the exact same results
- Provenance: Jobs store all necessary metadata
- Compute flexibility: local, slurm cluster, cloud
- Access to sorters: not always easy to set up even when using SpikeInterface
- Collaboration: add other GitHub users to a workspace
- Integration with DANDI

---

## Protocaas containerized processors

- Each spike sorter is packaged as a processor within a Protocaas app
- Here are the definitions for [kilosort3](https://github.com/scratchrealm/pc-spike-sorting/blob/main/kilosort3/main) and [mountainsort5](https://github.com/scratchrealm/pc-spike-sorting/blob/main/mountainsort5/main) processors.
- Apps are executables that live in containers for production, or on a file system during development
- When run with the appropriate environment variables, apps can:
    - Produce a spec.json (the input/output specs for the processors)
    - Run a job with that processor
    - During job execution the processor interacts with the central Protocaas API
        - Load the job inputs
        - Report the status and console output
        - Upload the job outputs

---

## Protocaas compute resources

![bg right:40% 90%](https://user-images.githubusercontent.com/3679296/272931152-c8d5bccb-2349-4326-b802-f95f141b508a.png)

- Users can use the default compute resources
- Or configure their own compute resources
- A compute resource is a daemon that runs on some server or machine
    - Watches for new jobs in the Protocaas database
    - Spawns the jobs based on the configuration (AWS, Slurm, local machine)
- Jobs are autonomous
    - Capable of reporting their own status to the central system
    - Does not need to communicate with the daemon

---

## Summary

Some tools for visualization and analysis of neurophysiology data are in progress:

- Figurl
    - Stable
- Neurosift
    - Initial version is stable
- Protocaas
    - Under active development, with CatalystNeuro

---

## Thank you

##### Figurl

Jeff Soules, Alessio Buccino, Loren Frank, Eric denovellis, Kyu Hyun Lee, Alison Comrie, Michael Coulter

##### Neurosift

Jeff Soules, Ben Dichter, Cody Baker

##### Protocaas

Ben Dichter, Luiz Tauffer

##### Thanks also to the DANDI team!