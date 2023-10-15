#pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cpu
#python -m pip install --upgrade --force-reinstall regex
#python -m pip install --force-reinstall soundfile
#python -m pip install --force-reinstall gradio
#python -m pip install imageio==2.4.1
#python -m pip install --upgrade youtube-dl
#python -m pip install moviepy
#
#python -m pip install --no-build-isolation -r requirements.txt
#python -m pip install --upgrade numpy
#python -m pip install --upgrade --force-reinstall numba
#python -m pip install --upgrade Cython
#
#python -m pip install --upgrade pyzmq
#python -m pip install pydantic==1.10.4
#python -m pip install ruamel.yaml

cd monotonic_align/
mkdir monotonic_align
python setup.py build_ext --inplace
cd ..
mkdir pretrained_models
# download data for fine-tuning
wget https://huggingface.co/datasets/Plachta/sampled_audio4ft/resolve/main/sampled_audio4ft_v2.zip
unzip sampled_audio4ft_v2.zip
# create necessary directories
mkdir video_data
mkdir raw_audio
mkdir denoised_audio
mkdir custom_character_voice
mkdir segmented_character_voice

PRETRAINED_MODEL="CJ" #@param ["CJE","CJ","C"]
if [[ $PRETRAINED_MODEL == "CJ" ]]; then
  wget https://huggingface.co/spaces/sayashi/vits-uma-genshin-honkai/resolve/main/model/D_0-p.pth -O ./pretrained_models/D_0.pth
  wget https://huggingface.co/spaces/sayashi/vits-uma-genshin-honkai/resolve/main/model/G_0-p.pth -O ./pretrained_models/G_0.pth
  wget https://huggingface.co/spaces/sayashi/vits-uma-genshin-honkai/resolve/main/model/config.json -O ./configs/finetune_speaker.json
elif [[ $PRETRAINED_MODEL == "CJE" ]]; then
  wget https://huggingface.co/spaces/Plachta/VITS-Umamusume-voice-synthesizer/resolve/main/pretrained_models/D_trilingual.pth -O ./pretrained_models/D_0.pth
  wget https://huggingface.co/spaces/Plachta/VITS-Umamusume-voice-synthesizer/resolve/main/pretrained_models/G_trilingual.pth -O ./pretrained_models/G_0.pth
  wget https://huggingface.co/spaces/Plachta/VITS-Umamusume-voice-synthesizer/resolve/main/configs/uma_trilingual.json -O ./configs/finetune_speaker.json
elif [[ $PRETRAINED_MODEL == "C" ]]; then
  wget https://huggingface.co/datasets/Plachta/sampled_audio4ft/resolve/main/VITS-Chinese/D_0.pth -O ./pretrained_models/D_0.pth
  wget https://huggingface.co/datasets/Plachta/sampled_audio4ft/resolve/main/VITS-Chinese/G_0.pth -O ./pretrained_models/G_0.pth
  wget https://huggingface.co/datasets/Plachta/sampled_audio4ft/resolve/main/VITS-Chinese/config.json -O ./configs/finetune_speaker.json
fi
